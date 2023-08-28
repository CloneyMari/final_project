class Client::SharesController < ApplicationController
  before_action :set_winner, only: :show

  def show; end

  def index
    @winners = Winner.published
  end

  private

  def set_winner
    @winner = Winner.includes(:user).find(params[:id])
  end
end