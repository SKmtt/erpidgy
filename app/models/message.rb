class Message < ApplicationRecord
  belongs_to :character
  belongs_to :room, required: false
end
