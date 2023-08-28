class SkiResortsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:query].nil? || params[:query].empty?
      @ski_resorts = SkiResort.all
    else
      @ski_resorts = SkiResort.search_by_name_and_location(params[:query])
    end
      # add additional index features in the future
    @markers = @ski_resorts.geocoded.map do |ski_resort|
      {
        lat: ski_resort.latitude,
        lng: ski_resort.longitude,
        title: ski_resort.name,
        description: ski_resort.description,
        info_window_html: render_to_string(partial: "info_window", locals: {ski_resort: ski_resort})
      }
    end
  end

  def show
    @ski_resort = SkiResort.find(params[:id])
    @check_in = CheckIn.new
    @review = Review.new
    @snow_report = SnowReport.new
  end
end
