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

  def available_locations
    @characters = current_user.characters
    @room = Room.find(params[:room])
  end

  def switch
    @room = Room.find(params[:room])
    location = @room.location
    @room.location = Location.find(params[:location])
    @room.save
    if location.character.nil?
      location.destroy
    end
  end

  def create_temporary
    @location = Location.new(permit_location)
    @location.save
    room = Room.find(params[:room])
    location = room.location
    room.location = @location
    room.save
    if location.character.nil?
      location.destroy
    end
  end

  private

  def permit_location
    params.require(:location).permit(:name, :description, :character_id)
  end
end
