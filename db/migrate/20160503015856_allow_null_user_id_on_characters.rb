class AllowNullUserIdOnCharacters < ActiveRecord::Migration
  def change
    change_column :characters, :user_id, :integer, null: true
  end
end
