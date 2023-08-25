class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses

  has_many :bets
  has_many :winners
  has_many :orders

  validates :phone_number, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
  }
  enum role: { client: 0, admin: 1 }
  has_many :children, class_name: 'User', foreign_key: :parent_id
  belongs_to :parent, class_name: 'User', foreign_key: :parent_id, optional: true, counter_cache: :children_members
end
