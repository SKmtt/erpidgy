class AdminController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_redirect

  def index
    @characters = Character.where(:status => 'pending')
  end

  def activate
    @character = Character.where(:id => params[:id]).first
    @character.status = 'active'
    if @character.save
      respond_to do |format|
        format.html { redirect_to admin_path }
        format.json { head :no_content }
        format.js { render :layout => false }
      end
    end
  end
end
