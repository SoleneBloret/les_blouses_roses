class ParticipationsController < ApplicationController
  def index
    @participations = current_user.participations.all.sorted_by_date_desc
  end

  def show
    @participation = Participation.find(params[:id])
  end

  def available
    unavailable_dates = current_user.unavailabilities.upcoming.flat_map { |u| (u.start_date..u.end_date).to_a }
    @participations = Participation.where(user: nil).sorted_by_date_desc
                                   .reject { |p| unavailable_dates.include?(p.date) }
  end

  def replacement
    @participation = Participation.find(params[:id])
  end

  def map
    @participation = Participation.find(params[:id])
  end

  def take
    @participation = Participation.find(params[:id])
    @participation.update!(user: current_user)
    redirect_to participations_path, notice: "Tu es bien inscrit(e) à cette permanence !"
  end

  def unavailable_for_replacement
    @participation = Participation.find(params[:id])

    unavailability = Unavailability.new(
      user: current_user,
      start_date: @participation.date,
      end_date: @participation.date
    )

    if unavailability.save
      redirect_to participations_path, notice: "Indisponibilité enregistrée."
    else
      redirect_to replacement_participation_path(@participation), alert: "Erreur lors de l'enregistrement."
    end
  end
end
