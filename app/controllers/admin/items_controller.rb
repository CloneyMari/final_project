class Admin::ItemsController < AdminController
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:categories).all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'Item created successfully'
      redirect_to admin_items_path
    else
      flash.now[:alert] = 'Item create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = 'Item destroyed successfully'
    redirect_to admin_items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :minimum_bets,
                                 :online_at, :offline_at, :status, :start_at, category_ids: [])
  end
end