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
        marker_id: ski_resort.id,
        marker_html: set_marker_icon(ski_resort, (ski_resort.current_condition_number == 0) ? (ski_resort.current_condition_number + 1) * 10 : (ski_resort.current_condition_number + 0.5) * 10),
        info_window_html: render_to_string(partial: "info_window", locals: {ski_resort: ski_resort})
      }
    end
  end

  def show
    @ski_resort = SkiResort.find(params[:id])
    @check_in = CheckIn.new
    @review = Review.new
    @snow_report = SnowReport.new
    @markers =
      [{
        lat: @ski_resort.latitude,
        lng: @ski_resort.longitude,
        title: @ski_resort.name,
        description: @ski_resort.description,
        marker_id: @ski_resort.id,
        marker_html: set_marker_icon(@ski_resort, (@ski_resort.current_condition_number == 0) ? (@ski_resort.current_condition_number + 1) * 10 : (@ski_resort.current_condition_number + 0.5) * 10),
        info_window_html: render_to_string(partial: "info_window", locals: {ski_resort: @ski_resort})
      }]
    @snow_ratings = @ski_resort.snow_reports.group_by_hour(:created_at).average(:rating)
  end

  private

  def set_marker_icon(ski_resort, size)
    render_to_string(partial: "shared/snow_cond_icon", locals: {ski_resort: ski_resort, size: size})
  end
end
