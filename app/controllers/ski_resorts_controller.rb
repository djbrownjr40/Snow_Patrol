class SkiResortsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @ski_resorts = SkiResort.search_by_name_and_location(params[:query])
      # add additional index features in the future
    @markers = @ski_resorts.geocoded.map do |ski_resort|
      {
        lat: ski_resort.latitude,
        lng: ski_resort.longitude,
        title: ski_resort.name,
        description: ski_resort.description
      }
    end
  end

  def show
  end
end
