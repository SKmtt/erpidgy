class MessageController < WebsocketRails::BaseController
  def create
    sprava = Message.new
    sprava.body = message[:body]
    sprava.character = Character.find(current_user.current_character_id)
    sprava.room = Room.find(message[:room])

    if sprava.save
      message[:user] = current_user.username
      message[:time] = sprava.created_at.strftime("%d.%m.%Y %T")
      message[:id] = sprava.id
      message[:fullname] = sprava.character.full_name
      message[:imgpath] = ActionController::Base.helpers.asset_path(sprava.character.profile_image_path)
      broadcast_message :create_success, message, :namespace => :messages
    else
      broadcast_message :create_fail, message, :namespace => :messages
    end
  end
end
