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
      redirect_to unavailabilities_path, notice: "Indisponibilité enregistrée."
    else
      @upcoming = current_user.unavailabilities.upcoming
      @past = current_user.unavailabilities.past
      render :new, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @unavailability = current_user.unavailabilities.find(params[:id])
  #   @unavailability.destroy
  #   redirect_to unavailabilities_path, notice: "Indisponibilité supprimée."
  # end

  private

  def unavailability_params
    p = params.require(:unavailability).permit(:start_date, :end_date, :reason)
    p[:end_date] = p[:start_date] if p[:end_date].blank?
    p
  end
end
