class Location < ApplicationRecord
  belongs_to :character, optional: true
end
