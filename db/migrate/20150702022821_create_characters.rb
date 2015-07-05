class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :user_id, null: false
      
      t.string :name, null: false
      t.string :gender, null: false

      t.timestamps null: false
    end
    add_index :characters, :user_id
    add_index :characters, :name, unique: true
  end
end
