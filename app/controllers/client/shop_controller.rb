class Client::ShopController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_offer, except: [:index, :create]

  def index
    @offers = Offer.active
  end

  def show
    @offer = Offer.find(params[:id])
    @order = Order.new
  end

  def create
    @offer = Offer.find_by(id: params[:order][:offer_id])
    @order = Order.new(offer_id: @offer.id)
    @order.amount = @offer.amount
    @order.coin = @offer.coins
    @order.user = current_user
    @order.genre = :deposit
    @order.offer = @offer
    if @order.save
      @order.submit!
      flash[:notice] = "Your purchase is complete"
    else
      flash[:alert] = @order.errors.full_messages.join(', ')
    end
    redirect_to shop_index_path
  end

  private

  def set_offer
    @offer = Offer.active.find(params[:id])
  end

end