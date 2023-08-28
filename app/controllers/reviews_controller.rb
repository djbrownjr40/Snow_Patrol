class ReviewsController < ApplicationController
  before_action :set_check_in, only:[:new, :index, :create, :show]

  def index
    @reviews = @check_in.reviews
  end

  def show
    @review = @check_in.reviews.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.check_in = @check_in
    if @review.save
      redirect_to ski_resort_path(@check_in.ski_resort), notice: 'Your review have submitted successfully! 🤙'
    else
      redirect_to ski_resort_path(@check_in.ski_resort)
    end
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:check_in_id])
  end

  def review_params
    params.require(:review).permit(:lift_wait_rating, :price_rating, :crowd_rating, :food_rating, :location_rating)
  end
end
