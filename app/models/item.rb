class Item < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  validates :name, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :minimum_bets, numericality: { greater_than: 0 }
  enum status: { active: 0, inactive: 1 }

  def destroy
    update(deleted_at: Time.current)
  end
end
