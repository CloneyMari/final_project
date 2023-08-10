class Address < ApplicationRecord
  LIMIT = 5
  enum genre: { home: 0, office: 1 }
  belongs_to :user

  belongs_to :region, class_name: 'Location::Region', foreign_key: 'address_region_id'
  belongs_to :province, class_name: 'Location::Province', foreign_key: 'address_province_id'
  belongs_to :city, class_name: 'Location::City', foreign_key: 'address_city_id'
  belongs_to :barangay, class_name: 'Location::Barangay', foreign_key: 'address_barangay_id'
  before_validation :limit_address_count

  private

  def limit_address_count
    errors.add(:base, "Only #{LIMIT} addresses are allowed per user") if user.addresses.size > LIMIT
  end
end
