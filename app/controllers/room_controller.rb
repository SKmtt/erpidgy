class RoomController < ApplicationController
  before_action :authenticate_user!

  def index
    @open_rooms = current_user.users_rooms.where(open: true)
  end

  def show
    @actual_room = Room.find(params[:id])
    current_user.update_active_room(UsersRoom.where(room_id: @actual_room, user_id: current_user).first)
    respond_to do |format|
      format.js
    end
  end

  def list
    all_open = current_user.users_rooms.where(open: true).pluck(:room_id)
    invited = current_user.users_rooms.where(status: %w(player owner spectator)).pluck(:room_id)
    @room_open = Room.where(is_open: 1).where.not(id: all_open)
    @room_invited = current_user.users_rooms.where(status: %w(player owner), open: false)
    @room_spectator = current_user.users_rooms.where(status: 'spectator', open: false)
    @room_closed = Room.where(is_open: 0).where.not(id: invited)
    # TODO filter already open chat, blacklisted persons by you and you blacklisted by person
    # @player_list
    respond_to do |format|
      format.js
    end
  end

  def open_room
    @actual_room = Room.find(params[:id])
    if current_user.can_open?(@actual_room)
      user_room = UsersRoom.where(room_id: @actual_room, user_id: current_user).first
      if user_room.nil?
        user_room = UsersRoom.new
        user_room.user_id = current_user.id
        user_room.room_id = @actual_room.id
        user_room.status = 'spectator'
        user_room.can_add_place = false
      end
      user_room.open = true
      user_room.save
      current_user.update_active_room(user_room)
    else
      @actual_room = nil
    end
    respond_to do |format|
      format.js
    end
  end

  def close_room
    user_room = UsersRoom.where(user_id: current_user, room_id: params[:id]).first
    user_room.open = false
    user_room.save

    if user_room.id == current_user.active_room_id
      active_room = UsersRoom.where(user_id: current_user, open: true).first
      if active_room.nil?
        current_user.update_attribute(:active_room_id, nil)
      else
        current_user.update_active_room(active_room)
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    @room = Room.new(permit_room)
    @room.save

    user_room = UsersRoom.new
    user_room.status = 'owner'
    user_room.open = true
    user_room.user = current_user
    user_room.room = @room
    user_room.can_add_place = true

    user_room.save

    current_user.update_active_room(user_room)

    respond_to do |format|
      format.js
    end
  end

  def manage_people
    @actual_room = Room.find(params[:id])
    invited = UsersRoom.where(room_id: @actual_room).pluck(:user_id)
    @users = User.where.not(id: invited).to_json(:only => [], :methods => [:value, :label]).html_safe
  end

  def add_player
    @user = User.find(params[:user])
    @room = Room.find(params[:room])
    create_user_room(@user, @room, 'player')

    respond_to do |format|
      format.js
    end
  end

  def add_spectator
    @user = User.find(params[:user])
    @room = Room.find(params[:room])
    create_user_room(@user, @room, 'spectator')

    respond_to do |format|
      format.js
    end
  end

  def remove_player
    @id = 0
    if current_user.has_status('owner', Room.find(params[:room]))
      user_room = UsersRoom.where(room_id: params[:room], user_id: params[:user]).first
      unless user_room.status == 'owner'
        @id = user_room.user.id
        user_room.destroy
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def get_message
    @message = Message.find(params[:id])
    unless UsersRoom.where(user_id: current_user, room_id: @message.room).length > 0
      @message = nil
    end
  end

# TODO update things below

  def edit
  end

  def destroy
  end

  def saveMessage
    message = Message.new(permit_message)
    message.character = current_user.characters.first
    message.scope = 'global'

    if message.save
      redirect_to request.url
    end
  end

  private

  def create_user_room(user, room, type)
    if current_user.has_status('owner', room)
      user_room = UsersRoom.where(user_id: user, room_id: room).first
      if user_room.nil?
        user_room = UsersRoom.new
        user_room.user = user
        user_room.room = room
        user_room.open = false
        user_room.can_add_place = false
      end

      user_room.status = type

      user_room.save
    end
  end

  def permit_room
    params.require(:room).permit(:name, :description, :is_open)
  end

  def permit_message
    params.require(:message).permit(:body)
  end

end
