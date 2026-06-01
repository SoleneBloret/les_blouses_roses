class Participation < ApplicationRecord
  belongs_to :permanence
  belongs_to :user
end
