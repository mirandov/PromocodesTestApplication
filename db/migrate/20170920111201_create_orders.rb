class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :description, null: false, limit: 128
      t.float :price, null: false
      t.string :promo_input, limit: 15
      t.references :promo, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
  def up
    execute("ALTER TABLE orders ADD CONSTRAIN price_check CHECK(price >= 0)")
  end

  def down
    execute("ALTER TABLE orders DROP CONSTRAIN price_check")
  end
end
