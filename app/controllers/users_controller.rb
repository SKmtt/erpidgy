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

  def update
    user = User.find(params[:id])
    user.update_attributes(permit_user)
  end

  def invite
    User.invite!(email: params[:user][:email], username: params[:user][:username])
    redirect_to root_path
  end

  private

  def permit_user
    params.permit(:id, :display_name, :status, :status_text)
  end
end
