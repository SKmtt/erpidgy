class Character < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :locations

  def profile_image_path
    "character_profile/#{id}.png"
  end

  def full_name
    "#{name} #{surname}"
  end
end
