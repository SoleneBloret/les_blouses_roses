class Permanence < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :reports
  has_many :participations
end
