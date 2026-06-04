class ReportsController < ApplicationController
  def new
    @participation = Participation.find(params[:participation_id])
    @permanence    = @participation.permanence
    @report        = Report.new
  end

  def create
    @participation = Participation.find(params[:participation_id])
    @permanence    = @participation.permanence
    @report        = Report.new(report_params)
    @report.permanence  = @permanence
    @report.week_number = @participation.week_number
    if @report.save
      redirect_to root_path, notice: "Compte-rendu envoyé !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report).permit(:patients_number, :feeling, :comment)
  end
end
