class AddActiveCharacterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_character_id, :integer
  end
end
