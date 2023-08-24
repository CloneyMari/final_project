class Order < ApplicationRecord
  include AASM
  enum genre: { deposit: 0, increase: 1, deduct: 2, bonus: 3, share: 4 }

  belongs_to :user
  belongs_to :offer, optional: true
  after_create :assign_serial_number

  aasm column: :state do
    state :pending, initial: true
    state :submitted, :cancelled, :paid

    event :submit do
      transitions from: :pending, to: :submitted
    end

    event :cancel do
      transitions from: [:submitted, :pending], to: :cancelled
      transitions from: :paid, to: :cancelled, guard: :can_cancel_increase?, after: [:update_user_coin_on_cancel, :decrease_total_deposit]
    end

    event :pay do
      transitions from: :submitted, to: :paid, guard: :can_deduct?, after: [:update_user_coin_on_pay, :increase_total_deposit]
    end
  end

  def update_user_coin_on_pay
    if deduct?
      user.update(coins: user.coins - coin)
    else
      user.update(coins: user.coins + coin)
    end
  end

  def increase_total_deposit
    user.update(total_deposit: user.total_deposit + amount) if deposit?
  end

  def update_user_coin_on_cancel
    if deduct?
      user.update(coins: user.coins + coin)
    else
      user.update(coins: user.coins - coin)
    end
  end

  def decrease_total_deposit
    user.update(total_deposit: user.total_deposit - amount) if deposit?
  end

  def can_cancel_increase?
    (!deduct? && user.coins >= coin) || deduct?
  end

  def can_deduct?
    (deduct? && user.coins >= coin) || !deduct?
  end

  def assign_serial_number
    number_count = user.orders.count.to_s
    date = Time.current.strftime('%y%m%d')
    self.update(serial_number: "#{date}-#{id}-#{user.id}-#{number_count.rjust(4, '0')}")
  end

end
