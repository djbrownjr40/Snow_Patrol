class ResortsController < ApplicationController
  def index
    @resorts = Resort.all
    # The `geocoded` scope filters only resorts with coordinates
    @markers = @resorts.geocoded.map do |resort|
      {
        lat: resort.latitude,
        lng: resort.longitude
      }
    end
  end

  def show

  end
end
