class Admin::WinnersController < AdminController
  before_action :set_winner, except: :index
  def index
    @winners = Winner.all
    @winners = @winners.where(serial_number: params[:serial_number]) if params[:serial_number].present?
    @winners = @winners.includes(:user).where(user: {email: params[:email]}) if params[:email].present?
    @winners = @winners.where(state: params[:state]) if params[:state].present?
    @winners = @winners.where("created_at >= (?)", params[:start_date]) if params[:start_date].present?
    @winners = @winners.where("created_at <= (?)", params[:end_date]) if params[:end_date].present?
  end


  def submit
    if @winner.submit!
      flash[:notice] = 'Submitted successfully'
    end
    redirect_to admin_winners_path
  end

  def pay
    if @winner.pay!
      flash[:notice] = 'Paid successfully'
    end
    redirect_to admin_winners_path
  end

  def ship
    if @winner.ship!
      flash[:notice] = 'Shipped successfully'
    end
    redirect_to admin_winners_path
  end

  def deliver
    if @winner.deliver!
      flash[:notice] = 'Delivered successfully'
    end
    redirect_to admin_winners_path
  end


  def publish
    if @winner.publish!
      flash[:notice] = 'Published successfully'
    end
    redirect_to admin_winners_path
  end

  def remove_publish
    if @winner.remove_publish!
      flash[:notice] = 'Removed publish successfully'
    end
    redirect_to admin_winners_path
  end

  private

  def set_winner
    @winner = Winner.find(params[:id])
  end
end
