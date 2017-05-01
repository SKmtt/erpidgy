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
  end

  def create
    @room = Room.new(permit_room)
    @room.parametrized = @room.name.parameterize('_')
    @room.save

    redirect_to miestnosti_path
  end

  def edit
  end

  def destroy
  end

private

  def permit_room
    params.require(:room).permit(:name, :description)
  end

end
