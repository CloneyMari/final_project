class ChangeAmountColumnTypeInOffers < ActiveRecord::Migration[7.0]
  def change
    change_column(:offers, :amount, :decimal)
  end
end
