class AdminController < ApplicationController
  def index
    @characters = Character.where(:status => 'pending')
  end

  def activate
    @character = Character.where(:id => params[:id]).first
    @character.status = 'active'
    if @character.save
      puts 'ukladam' + @character.name + @character.status
      respond_to do |format|
        format.html { redirect_to admin_path }
        format.json { head :no_content }
        format.js { render :layout => false }
      end
    end
  end
end
