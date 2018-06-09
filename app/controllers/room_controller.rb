class RoomController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.where(:parametrized => params[:id]).first
    if @room.nil?
      redirect_to domov_path
    end

    @messages = Message.where(:game_id => @room.games.ids).or(Message.where(:scope => 'global'))

  end

  def create
    @room = Room.new(permit_room)
    @room.parametrized = @room.name.parameterize('_')
    @room.save

    redirect_to '/miestnosti'
  end

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
    params.require(:room).permit(:name, :description)
  end

  def permit_message
    params.require(:message).permit(:body)
  end

end
