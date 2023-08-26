class Client::PrizeController < ApplicationController
  def show
    @winner = Winner.find(params[:id])
  end

  def update
    @winner = Winner.won.find(params[:id])
    if @winner.update(address_id: params[:winner][:address_id])
      @winner.claim!
      flash[:notice] = "Successfully updated"
      redirect_to profiles_path(category: 'winning')
    else
      flash[:alert] = "Fail to update"
      render :show
    end
  end

end