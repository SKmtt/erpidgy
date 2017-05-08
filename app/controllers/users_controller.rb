class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.where(:username => params[:id]).first
    if @user.nil?
      redirect_to domov_path
    end
  end
end
