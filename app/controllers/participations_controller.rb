class ParticipationsController < ApplicationController
  def index
    @participations = current_user.participations.all.sorted_by_date_desc
  end

  def show
    @participation = Participation.find(params[:id])
  end

  def available
    # TODO: charger ici les permanences disponibles (ex: Permanence.available_for(current_user))
    @participations = Participation.all.where(user: nil).sorted_by_date_desc
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
end
