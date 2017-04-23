class Room < ApplicationRecord
  has_many :replies

  def to_param
    "#{id}-#{name}"
  end
end
