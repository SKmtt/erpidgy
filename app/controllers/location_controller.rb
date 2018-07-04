class LocationController < ApplicationController
  def create
    @location = Location.new(permit_location)
    @location.save
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    respond_to do |format|
      format.js
    end
  end

  def update
    @location = Location.find(params[:id])
    @location.update_attributes(permit_location)
    respond_to do |format|
      format.js
    end
  end


  private

  def permit_location
    params.require(:location).permit(:name, :description, :character_id)
  end
end
