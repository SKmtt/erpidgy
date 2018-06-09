class Room < ApplicationRecord
  has_many :games

  def to_param
    "#{id}-#{name}"
  end
end
