class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.integer :user_id
      t.string :line
      t.string :city
      t.string :country
      t.string :postcode
      t.string :country_code

      t.timestamps null: false
    end
  end
end
