class SnowReportsController < ApplicationController

  def create
    @check_in = CheckIn.find(params[:check_in_id])
    @snow_report = @check_in.snow_reports.build(snow_reports_params)

    if @snow_report.save
      redirect_to check_in_path(@check_in), notice: 'Snow report submitted successfully. Thank you!'
    else
      render 'new'
    end
  end

  private

  def snow_reports_params
    params.require(:snow_report).permit(:rating)
  end
end
