class Report < ApplicationRecord
  belongs_to :permanence

  FEELINGS = { 0 => "Difficile", 1 => "Correct", 2 => "Bien", 3 => "Excellent" }

  validates :patients_number, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :feeling, presence: true
end
