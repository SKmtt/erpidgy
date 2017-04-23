class RoomController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @room = Room.where(:name => params[:id]).first
  end

  def create
  end

  def new
  end

  def edit
  end

  def destroy
  end
end
