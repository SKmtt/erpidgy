class RoomController < ApplicationController
  before_action :authenticate_user!

  def index
    @open_rooms = current_user.users_rooms.where(open: true)
  end

  def show
    @actual_room = Room.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def list
    all_open = current_user.users_rooms.where(open: true).pluck(:room_id)
    invited = current_user.users_rooms.where(status: %w(invited owner spectator)).pluck(:room_id)
    @room_open = Room.where(is_open: 1).where.not(id: all_open)
    @room_invited = current_user.users_rooms.where(status: %w(invited owner), open: false)
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
    user_room = UsersRoom.where(room_id: @actual_room, user_id: current_user).first
    if user_room.nil?
      user_room = UsersRoom.new
      user_room.user_id = current_user.id
      user_room.room_id = @actual_room.id
      user_room.status = ''
      user_room.can_add_place = false
    end
    user_room.open = true
    user_room.save

    respond_to do |format|
      format.js
    end
  end

  def close_room
    user_room = UsersRoom.where(user_id: current_user, room_id: params[:id]).first
    user_room.open = false
    user_room.save

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

    respond_to do |format|
      format.js
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

  def permit_room
    params.require(:room).permit(:name, :description, :is_open)
  end

  def permit_message
    params.require(:message).permit(:body)
  end

end
