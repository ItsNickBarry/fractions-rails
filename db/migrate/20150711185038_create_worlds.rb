class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.string :name
      
      t.timestamps null: false
    end
  end
end
