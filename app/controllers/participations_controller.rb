class ParticipationsController < ApplicationController
  def index
    @participations = current_user.participations.all.sorted_by_date_desc
  end

  def show
    @participation = Participation.find(params[:id])
  end

  def available
    # TODO: charger ici les permanences disponibles (ex: Permanence.available_for(current_user))
    @participations = Participation.where.not(user_id: current_user.id)
  end

  def map
    @participation = Participation.find(params[:id])
  end
end
