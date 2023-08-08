class Client::ProfilesController < ApplicationController
  before_action :authenticate_user!

    def show
    end
    def edit
      @client = current_user
    end

    def update
      @client = current_user

      if @client.update(client_params)
        redirect_to profiles_path, notice: "Successfully Updated"
      else
        render :edit
      end
    end

    private

    def client_params
      params.require(:user).permit(:username, :email, :phone_number, :image)
    end

  end
