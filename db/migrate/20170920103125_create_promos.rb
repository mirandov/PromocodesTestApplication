class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :name, null: false, limit: 15
      t.float :sale, null: false
      t.integer :quantity

      t.index [:name], unique: true
      
      t.timestamps null: false
    end
  end

  def up
    execute("ALTER TABLE promos ADD CONSTRAIN sale_check CHECK(sale >= 0)")
    execute("ALTER TABLE promos ADD CONSTRAIN quantity_check CHECK(quantity >= 0)")
  end

  def down
    execute("ALTER TABLE promos DROP CONSTRAIN sale_check")
    execute("ALTER TABLE promos DROP CONSTRAIN quantity_check")
  end
end
