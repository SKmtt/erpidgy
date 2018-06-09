class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.where(:username => params[:id]).first
    if @user.nil?
      redirect_to domov_path
    elsif @user.profile.nil?
      Profile.new(:user => @user).save
    end

  end
end
