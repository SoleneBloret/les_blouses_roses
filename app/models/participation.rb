class Participation < ApplicationRecord
  belongs_to :permanence
  belongs_to :user

  FRENCH_WEEKDAYS = {
    "Lundi" => 1, "Mardi" => 2, "Mercredi" => 3,
    "Jeudi" => 4, "Vendredi" => 5, "Samedi" => 6, "Dimanche" => 7
  }.freeze

  # DEFINITION :
  # permet d'afficher uniquement les participations qui ne sont pas passées.
  def self.sorted_by_date_desc
    includes(permanence: :location)
      .sort_by(&:date)
      .select { |p| p.date >= Date.today }
  end

  # DEFINITION :
  # permet d'avoir la date au bon format dans les cards des participations
  def date
    day_number = FRENCH_WEEKDAYS[permanence.week_day]
    Date.commercial(permanence.year, week_number, day_number)
  end
end
