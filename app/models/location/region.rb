class Location::Region < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  has_many :provinces

  has_many :addresses, class_name: 'Address', foreign_key: 'address_region_id'

end
