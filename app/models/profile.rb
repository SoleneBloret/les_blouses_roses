class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :role, presence: true

  validates :phone_number, presence: true
  validates :phone_number, uniqueness: true
end
