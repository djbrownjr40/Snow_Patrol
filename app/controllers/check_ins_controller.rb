class CheckInsController < ApplicationController

  def create
    @ski_resort = SkiResort.find(params[:ski_resort_id])
    @check_in = CheckIn.new(user: current_user, ski_resort: @ski_resort)
    if @check_in.save
      redirect_to ski_resort_path(@ski_resort)
    else
      render 'ski_resorts/show', status: :unprocessable_entity
    end
  end

  def update
  end

end
