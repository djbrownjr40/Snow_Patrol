class SkiResortsController < ApplicationController
  def index
    if params[:location].present? || params[:name].present? || params[:average_rating].present?
      @ski_resorts = SkiResort.where(location: params[:location], name: params[:name], average_rating: params[:average_rating])
    else
      @ski_resorts = SkiResort.all
    end
  end
  # add additional index features in the future
end
