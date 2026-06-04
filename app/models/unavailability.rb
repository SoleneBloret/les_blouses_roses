class Unavailability < ApplicationRecord
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_on_or_after_start_date

  scope :upcoming, -> { where("end_date >= ?", Date.today).order(:start_date) }
  scope :past, -> { where("end_date < ?", Date.today).order(start_date: :desc) }

  def single_day?
    start_date == end_date
  end

  private

  def end_date_on_or_after_start_date
    return unless start_date && end_date

    errors.add(:end_date, "doit être égale ou postérieure à la date de début") if end_date < start_date
  end
end
