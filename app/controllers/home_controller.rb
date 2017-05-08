class HomeController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def index
    @rooms = Room.all
    @users = User.all
  end


end
