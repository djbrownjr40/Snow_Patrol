class SkiResortsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:location].present? || params[:name].present? || params[:average_rating].present?
      @ski_resorts = SkiResort.where(location: params[:location], name: params[:name], average_rating: params[:average_rating])
    else
      @ski_resorts = SkiResort.all
      # add additional index features in the future
    end
    @markers = @ski_resorts.geocoded.map do |ski_resort|
      {
        lat: ski_resort.latitude,
        lng: ski_resort.longitude
      }
    end
  end

  def show
  end
end
