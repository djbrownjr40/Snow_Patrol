class SnowReportsController < ApplicationController
  def index
    @snow_reports = @check_in.snow_reports
  end

  def show
    @snow_report = @check_in.snow_reports.find(params[:id])
  end

  def create
    @ski_resort = SkiResort.find(params[:ski_resort_id])
    @check_in = current_user.active_check_in
    @snow_report = @check_in.snow_reports.build(snow_report_params)

    if @snow_report.save
      redirect_to ski_resort_path(@ski_resort), notice: 'Your review have submitted successfully! 🤙'
    else
      render 'new'
    end
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:check_in_id])
  end

  def snow_report_params
    params.require(:snow_report).permit(:rating)
  end
end
