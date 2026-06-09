class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    unless current_user
      redirect_to new_user_session_path
      return
    end

    @profile = current_user.profile
    load_participations_data

    # Calcul affichage du nombre de permanences de remplacement à afficher :
    unavailable_dates = current_user.unavailabilities.upcoming.flat_map { |u| (u.start_date..u.end_date).to_a }

    already_on = current_user.participations.pluck(:permanence_id, :week_number)

    @participations = Participation.where(user: nil).sorted_by_date_desc
                                   .reject { |p| unavailable_dates.include?(p.date) }
                                   .reject { |p| already_on.include?([p.permanence_id, p.week_number]) }
  end

  private

  def load_participations_data
    all = current_user.participations.includes(permanence: %i[location reports]).sort_by(&:date)
    today = Date.today
    past = all.select { |p| p.date < today }

    @next_participation = all.find { |p| p.date >= today }
    @last_participation = past.last
    @last_participation = nil if report_exists?(@last_participation)
    compute_monthly_impact(past.select { |p| p.date.year == today.year && p.date.month == today.month })
  end

  def report_exists?(participation)
    return false unless participation

    participation.permanence.reports.any? { |r| r.week_number == participation.week_number }
  end

  def compute_monthly_impact(this_month)
    @monthly_hours = this_month.sum { |p| p.permanence.end_time - p.permanence.start_time }
    @monthly_patients = this_month.sum do |p|
      p.permanence.reports.find { |r| r.week_number == p.week_number }&.patients_number.to_i
    end
  end

  def menu
    @profiles_count = Profile.count
  end
end
