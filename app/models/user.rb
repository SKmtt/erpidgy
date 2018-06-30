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

end
