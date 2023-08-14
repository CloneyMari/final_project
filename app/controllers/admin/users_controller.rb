class Admin::UsersController < AdminController

  def index
    @users = User.client.all
  end
end