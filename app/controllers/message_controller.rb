class MessageController < WebsocketRails::BaseController
  def create
    sprava = Message.new
    sprava.body = message[:body]
    sprava.character = Character.find(current_user.current_character_id)
    sprava.room = Room.find(message[:room])

    if sprava.save
      message[:user] = current_user.id
      message[:body] = ''
      message[:msg_id] = sprava.id
      broadcast_message :create_success, message, :namespace => :messages
    end
  end

  def delete
    msg = Message.find(message[:id])
    # TODO allow also owner and admin deletion
    if !msg.nil? && current_user.id == msg.character.user.id
      if msg.destroy
        broadcast_message :delete_success, message, :namespace => :messages
      end
    end
  end
end
