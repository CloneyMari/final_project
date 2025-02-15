class Api::V1::CitiesController < ApplicationController

  def index
    province = Location::Province.find_by_id(params[:province_id])
    cities = if province
               province.cities
             else
               Location::City.all
             end

    render json: cities, each_serializer: CitySerializer
  end

  def show
    city = Location::City.find(params[:id])
    render json: city, serializer: CitySerializer
  end
end