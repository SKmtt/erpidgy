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

  def update
    msg = Message.find(message[:id])

    if !msg.nil? && current_user.id == msg.character.user.id
      msg.body = message[:body]
      if msg.save
        message[:body] = ''
        broadcast_message :update_success, message, :namespace => :messages
      end
    end
  end

  def end_game
    userroom = UsersRoom.where(user_id: current_user, room_id: message[:id]).first
    if userroom.status.eql?('owner')
      room = userroom.room
      room.is_active = false

      UsersRoom.where(room_id: message[:id]).each do |r|
        r.open = false
        r.save
      end

      User.where(active_room_id: message[:id]).each do |u|
        u.active_room_id = null
        u.save
      end

      if room.save
        broadcast_message :end_game_success, message, :namespace => :games
      end
    end
  end
end
