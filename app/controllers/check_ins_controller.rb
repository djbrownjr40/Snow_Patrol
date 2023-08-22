class CheckInsController < ApplicationController

  def create
    @ski_resort = Resort.find(params[:ski_resort_id])
    @check_in = CheckIn.new(user: current_user, ski_resort: @ski_resort)
    if @check_in.save
      redirect_to resort_check_ins_path(@ski_resort)
    else
      render 'ski_resorts/show', status: :unprocessable_entity
    end
  end

  def update

  end

end
