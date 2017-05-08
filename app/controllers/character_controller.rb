class CharacterController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def destroy
  end

  def create
    @character = current_user.characters.create(permit_character)
    if @character.save
      respond_to do |format|
        format.html { redirect_to users_path(current_user.username) }
        format.js { }
      end
    end
  end

  def new
  end

  def edit
  end

  def index
  end

  private

  def permit_character
    params.require(:character).permit(:name, :surname, :description)
  end
end
