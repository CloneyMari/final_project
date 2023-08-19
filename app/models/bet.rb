class Bet < ApplicationRecord
  include AASM

  belongs_to :item
  belongs_to :user
  before_validation :deduct_user_coins
  after_create :assign_serial_number

  aasm column: :state do
    state :betting, initial: true
    state :won, :lost, :cancelled

    event :win do
      transitions from: :betting, to: :won
    end

    event :lose do
      transitions from: :betting, to: :lost
    end

    event :cancel do
      transitions from: :betting, to: :cancelled, success: :refund_coins
    end
  end

  def assign_serial_number
    bet_count = Bet.where(batch_count: item.batch_count, item: item).count.to_s
    date = Time.current.strftime('%y%m%d')
    self.update(serial_number: "#{date}-#{item.id}-#{item.batch_count}-#{bet_count.rjust(4, '0')}")
  end

  def deduct_user_coins
    return user.update(coins: user.coins - 1) if user.coins > 0
    errors.add(:base, 'insufficient coins')
  end

  def refund_coins
    user.update(coins: user.coins + 1)
  end
end
