class ParticipationsController < ApplicationController
  def index
    @participations = Participation.sorted_by_date_desc
  end

  def show
    @participation = Participation.find(params[:id])
  end
end
