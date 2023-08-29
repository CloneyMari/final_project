class Admin::OrdersController < AdminController
  before_action :set_order, except: :index

  def index
    @orders = Order.includes(:user, :offer).all
    @orders = @orders.where(serial_number: params[:serial_number]) if params[:serial_number].present?
    @orders = @orders.where(user: { email: params[:email] }) if params[:email].present?
    @orders = @orders.where(state: params[:state]) if params[:state].present?
    @orders = @orders.where(genre: params[:genre]) if params[:genre].present?
    @orders = @orders.where(offer: { genre: params[:offer_genre] }) if params[:offer].present?
    @orders = @orders.where("created_at >= (?)", params[:start_date]) if params[:start_date].present?
    @orders = @orders.where("created_at <= (?)", params[:end_date]) if params[:end_date].present?
    @amount_total = @orders.sum(&:amount)
    @coin_total = @orders.sum(&:coin)
    @orders = @orders.page(params[:page]).per(5)
    @amount_subtotal = @orders.sum(&:amount)
    @coin_subtotal = @orders.sum(&:coin)
  end

  def pay
    if @order.pay!
      flash[:notice] = 'Order Successfully Paid'
    else
      flash[:alert] = 'Payment Unsuccessful'
    end
    redirect_to admin_orders_path
  end

  def cancel
    if @order.cancel!
      flash[:notice] = 'Cancelled successfully'
    end
    redirect_to admin_orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end




