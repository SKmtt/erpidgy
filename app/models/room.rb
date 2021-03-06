class Room < ApplicationRecord
  has_many :messages
  has_many :users_rooms, dependent: :delete_all
  has_many :users, through: :users_rooms
  belongs_to :location, optional: true

  def to_param
    "#{id}-#{name}"
  end
end
