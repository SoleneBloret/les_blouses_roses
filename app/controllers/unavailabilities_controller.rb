class UnavailabilitiesController < ApplicationController
  def new
    @upcoming = current_user.unavailabilities.upcoming
    @past = current_user.unavailabilities.past
    @unavailability = Unavailability.new
  end

  def create
    @unavailability = Unavailability.new(unavailability_params)
    @unavailability.user = current_user
    if @unavailability.save
      # aller chercher les participations avec même week number
      @participations = current_user.participations.where(week_number: @unavailability.week_numbers)
      @participations.each do |participation|
        participation.update!(user_id: nil, substitute: "true")
      end
      redirect_to root_path, notice: "Indisponibilité enregistrée."
    else
      @upcoming = current_user.unavailabilities.upcoming
      @past = current_user.unavailabilities.past
      render :new, status: :unprocessable_entity
    end
  end

  # ------------------------------------ #
  # --------- METHODES PRIVEES --------- #
  # ------------------------------------ #

  private

  def unavailability_params
    p = params.require(:unavailability).permit(:start_date, :end_date, :reason)
    p[:end_date] = p[:start_date] if p[:end_date].blank?
    p
  end
end
