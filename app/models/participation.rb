class Participation < ApplicationRecord
  belongs_to :permanence
  belongs_to :user

  FRENCH_WEEKDAYS = {
    "Lundi" => 1, "Mardi" => 2, "Mercredi" => 3,
    "Jeudi" => 4, "Vendredi" => 5, "Samedi" => 6, "Dimanche" => 7
  }.freeze

  def date
    day_number = FRENCH_WEEKDAYS[permanence.week_day]
    Date.commercial(permanence.year, week_number, day_number)
  end
end
