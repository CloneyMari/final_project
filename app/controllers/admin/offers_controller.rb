class Admin::OffersController < AdminController
  before_action :set_offer, only: [:edit, :update, :destroy]

  def index
    @offers = Offer.all
    @offers = @offers.where(genre: params[:genre]) if params[:genre].present?
    @offers = @offers.where(status: params[:status]) if params[:status].present?
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      flash[:notice] = 'Offer created successfully'
      redirect_to admin_offers_path
    else
      flash.now[:alert] = 'Offer create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @offer.update(offer_params)
      flash[:notice] = 'Offer updated successfully'
      redirect_to admin_offers_path
    else
      flash.now[:alert] = 'Offer update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @offer.destroy
      flash[:notice] = 'Successfully deleted'
    else
      flash[:alert] = 'Deleted Failed'
    end
    redirect_to admin_offers_path
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:image, :name, :genre, :status, :amount, :coins)
  end

end


