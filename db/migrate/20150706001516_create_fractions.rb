class CreateFractions < ActiveRecord::Migration
  def change
    create_table :fractions do |t|
      t.string :name, null: false
      t.string :ancestry

      t.timestamps null: false
    end
    add_index :fractions, :name, unique: true
    add_index :fractions, :ancestry
  end
end
