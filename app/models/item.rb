class Item < ApplicationRecord
  include AASM

  mount_uploader :image, ImageUploader
  default_scope { where(deleted_at: nil) }
  validates :name, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :minimum_bets, numericality: { greater_than: 0 }
  enum status: { active: 0, inactive: 1 }

  has_many :item_category_ships
  has_many :categories, through: :item_category_ships
  has_many :bets
  has_many :winners

  aasm column: :state do
    state :pending, initial: true
    state :starting, :paused, :ended, :cancelled

    event :start do
      transitions from: :paused, to: :starting
      transitions from: [:pending, :ended, :cancelled],
                  to: :starting, guards: [:quantity_enough?, :offline_at_in_future?, :active?], success: [:deduct_quantity, :increase_batch_count]
    end

    event :pause do
      transitions from: :starting, to: :paused
    end

    event :end do
      transitions from: :starting, to: :ended
    end

    event :cancel do
      transitions from: :starting, to: :cancelled, success: :cancel_bets
    end
  end

  def deduct_quantity
    self.update(quantity: self.quantity - 1)
  end

  def increase_batch_count
    self.update(batch_count: self.batch_count + 1)
  end

  def quantity_enough?
    quantity > 0
  end

  def offline_at_in_future?
    Date.current < offline_at
  end


  def destroy
    update(deleted_at: Time.current)
  end

  def cancel_bets
    bets.each do |bet|
      bet.cancel if bet.may_cancel?
    end
  end
end
