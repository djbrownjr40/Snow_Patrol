class SnowReportsController < ApplicationController
  def index
    @snow_reports = @check_in.snow_reports
  end

  def show
    @snow_report = @check_in.snow_reports.find(params[:id])
  end

  def create
    @check_in = CheckIn.find(params[:check_in_id])
    @snow_report = @check_in.snow_report.build(snow_report_params)

    if @snow_report.save
      redirect_to check_in_path(@check_in), notice: 'Your review have submitted successfully! 🤙'
    else
      render 'new'
    end
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:check_in_id])
  end

  private

  def snow_report_params
    params.require(:snow_report).permit(:rating)
  end
end
