class Api::V1::BarangaysController < ApplicationController

  def index
    city = Location::City.find_by_id(params[:city_id])
    barangays = if city
                  city.barangays
                else
                  Location::Barangay.all
                end
    render json: barangays, each_serializer: BarangaySerializer
  end

  def show
    barangay = Location::Barangay.find(params[:id])
    render json: barangay, serializer: BarangaySerializer
  end
end