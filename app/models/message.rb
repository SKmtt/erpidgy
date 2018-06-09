class Message < ApplicationRecord
  belongs_to :character
  belongs_to :game, required: false
end
