class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :genre
      t.string :name
      t.string :street_address
      t.string :phone_number
      t.string :remark
      t.boolean :is_default
      t.references :user
      t.references :address_region
      t.references :address_province
      t.references :address_city
      t.references :address_barangay

      t.timestamps
    end
  end
end
