class ReviewsController < ApplicationController
  def index
    @reviews = @check_in.reviews
  end

  def show
    @review = @check_in.reviews.find(params[:id])
  end

  def create
    @check_in = CheckIn.find(params[:check_in_id])
    @review = @check_in.reviews.build(reviews_params)

    if @review.save
      redirect_to check_in_path(@check_in), notice: 'Your report have submitted successfully. Thank you!'
    else
      render 'new'
    end
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:check_in_id])
  end
end
