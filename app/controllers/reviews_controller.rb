class ReviewsController < ApplicationController

  def index
    @reviews = @check_in.reviews
  end

  def show
    @review = @check_in.reviews.find(params[:id])
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:check_in_id])
  end
end
