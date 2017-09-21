class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :role_users do |t|
      t.references :role, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.json :data

      t.timestamps null: false
    end
  end
end
