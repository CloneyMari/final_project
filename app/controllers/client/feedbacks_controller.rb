class Client::FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_winner

  def show; end

  def update
    if @winner.may_share? && @winner.update(winner_params)
      @winner.share!
      flash[:notice] = "Successfully updated"
      redirect_to profiles_path(category: 'winning')
    else
      render :show
    end
  end

  private

  def set_winner
    @winner = current_user.winners.delivered.find(params[:prize_id])
  end

  def winner_params
    params.require(:winner).permit(:comment, :picture)
  end

end
