class MessageController < WebsocketRails::BaseController
  def create
    sprava = Message.new
    sprava.body = message[:body]
    sprava.scope = 'global'
    sprava.character = Character.find(current_user.current_character_id)

    message[:user] = current_user.username

    if sprava.save
      broadcast_message :create_success, message, :namespace => :messages
    else
      broadcast_message :create_fail, message, :namespace => :messages
    end
  end
end
