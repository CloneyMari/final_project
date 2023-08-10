class Client::AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      flash[:notice] = 'Address created successfully'
      redirect_to addresses_path
    else
      flash.now[:alert] = 'Address create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @address.update(post_params)
      flash[:notice] = 'Address updated successfully'
      redirect_to addresses_path
    else
      flash.now[:alert] = 'Address update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = 'Address destroyed successfully'
    redirect_to addresses_path
  end

  private

  def set_address
    @address = current_user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:address_region_id, :address_province_id,
                                    :address_city_id, :address_barangay_id, :genre, :name,
                                    :street_address, :phone_number, :remark, :is_default)
  end
end




