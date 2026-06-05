class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    redirect_to new_user_session_path and return unless current_user

    @profile = current_user.profile
    load_participations_data
    @substitute_count = Participation.where(user_id: nil, substitute: true).count
  end

  private

  def load_participations_data
    all = current_user.participations.includes(permanence: %i[location reports]).sort_by(&:date)
    today = Date.today
    past = all.select { |p| p.date < today }

    @next_participation = all.find { |p| p.date >= today }
    @last_participation = past.last
    compute_monthly_impact(past.select { |p| p.date.year == today.year && p.date.month == today.month })
  end

  def compute_monthly_impact(this_month)
    @monthly_hours = this_month.sum { |p| p.permanence.end_time - p.permanence.start_time }
    @monthly_patients = this_month.sum do |p|
      p.permanence.reports.find { |r| r.week_number == p.week_number }&.patients_number.to_i
    end
  end
end
