class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :characters
  has_one :profile
  has_many :users_rooms, dependent: :delete_all
  has_many :rooms, through: :users_rooms
  attribute :email, :string

  def profile_link
    "/users/#{username}"
  end

  def room_link(room)
    "#{id}/#{room.id}"
  end

  def label
    username
  end

  def value
    id
  end

  def has_status(status, room)
    user_room = UsersRoom.where(user_id: id, room_id: room).first
    user_room.status.eql?(status)
  end

  def can_open?(room)
    if room.is_open == 1 || UsersRoom.where(user_id: id, room_id: room).size > 0
      return true
    end
    false
  end
end
