class Client::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
    @client = current_user
  end

  def update
    @client = current_user

    if @client.update(update_without_password_params)
      redirect_to profiles_path, notice: "Successfully Updated"
    else
      @client.update(update_with_password_params)
      redirect_to profiles_path, notice: "Successfully Updated"
    end
  end

  private

  def client_params
  end

  def update_without_password_params
    params.require(:user).permit(:phone_number, :username, :image)
  end

  def update_with_password_params
    params.require(:user).permit(:username, :email, :phone_number, :image, :password)
  end
end


