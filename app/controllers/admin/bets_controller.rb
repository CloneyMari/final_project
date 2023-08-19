class Admin::BetsController < AdminController
  def index
    @bets = Bet.all
    @bets = @bets.includes(:user).where(user: {email: params[:email]}) if params[:email].present?
    @bets = @bets.includes(:item).where(item: {name: params[:item_name]}) if params[:item_name].present?
    @bets = @bets.where(serial_number: params[:serial_number]) if params[:serial_number].present?
    @bets = @bets.where("created_at >= (?)", params[:start_date]) if params[:start_date].present?
    @bets = @bets.where("created_at <= (?)", params[:end_date]) if params[:end_date].present?
    @bets = @bets.where(state: params[:state]) if params[:state].present?
  end

  def cancel
    @bet = Bet.find(params[:bet_id])
    if @bet.cancel!
      flash[:notice] = 'Cancelled successfully'
    end
    redirect_to admin_bets_path
  end
end