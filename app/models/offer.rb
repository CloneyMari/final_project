class Offer < ApplicationRecord
  validates :image, :name, :genre, :status, :amount, :coins, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :coins, numericality: { greater_than_or_equal_to: 0 }
  mount_uploader :image, ImageUploader

  has_many :orders

  enum status: { active: 0, inactive: 1 }
  enum genre: {one_time: 0, monthly: 1, weekly: 2, daily: 3, regular: 4}
end
