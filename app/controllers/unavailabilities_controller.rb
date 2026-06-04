class UnavailabilitiesController < ApplicationController
  def index
    @upcoming = current_user.unavailabilities.upcoming
    @past = current_user.unavailabilities.past
    @unavailability = Unavailability.new
  end

  def create
    @unavailability = current_user.unavailabilities.build(unavailability_params)
    if @unavailability.save
      redirect_to unavailabilities_path, notice: "Indisponibilité enregistrée."
    else
      @upcoming = current_user.unavailabilities.upcoming
      @past = current_user.unavailabilities.past
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @unavailability = current_user.unavailabilities.find(params[:id])
    @unavailability.destroy
    redirect_to unavailabilities_path, notice: "Indisponibilité supprimée."
  end

  private

  def unavailability_params
    p = params.require(:unavailability).permit(:start_date, :end_date, :reason)
    p[:end_date] = p[:start_date] if p[:end_date].blank?
    p
  end
end
