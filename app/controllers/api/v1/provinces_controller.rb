class Api::V1::ProvincesController < ApplicationController

  def index
    region = Location::Region.find_by_id(params[:region_id])
    provinces = if region
                  region.provinces
                else
                  Location::Province.all
                end

    render json: provinces, each_serializer: ProvinceSerializer
  end

  def show
    province = Location::Province.find_by_id(params[:id])
    render json: province, serializer: ProvinceSerializerrovince
  end
end