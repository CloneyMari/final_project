class Api::V1::RegionsController < ApplicationController

  def index
    regions = Location::Region.all
    render json: regions, each_serializer: RegionSerializer
  end

  def show
    region = Location::Region.find(params[:id])
    render json: region, serializer: RegionSerializer
  end
end