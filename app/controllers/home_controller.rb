class HomeController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def index
    @rooms = Room.all
    @users = User.all

    if current_user.characters.sum(:id) == 0
      redirect_to current_user.profile_link
    elsif current_user.current_character_id.nil?
      current_user.current_character_id = current_user.characters.first.id
      current_user.save!
    end
  end


end
