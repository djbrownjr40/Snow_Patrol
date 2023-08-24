class SnowReportsController < ApplicationController
  def index
    @snow_reports = @check_in.snow_reports
  end

  def show
    @snow_report = @check_in.snow_reports.find(params[:id])
  end

  def create
    raise
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:check_in_id])
  end
end
