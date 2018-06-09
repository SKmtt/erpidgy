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
        format.js {}
      end
    end
  end

  def new
  end

  def edit
  end

  def index
  end

  def switch_current
    # TODO check if it is valid character
    current_user.current_character_id = params[:id]
    if current_user.save
      puts 'setting new character'
      respond_to do |format|
        format.json { head :no_content }
        format.js { render :layout => false }
      end
    end
  end

  private

  def permit_character
    params.require(:character).permit(:name, :surname, :description)
  end
end
