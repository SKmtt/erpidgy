class Reply < ApplicationRecord
  belongs_to :user, :room
end
