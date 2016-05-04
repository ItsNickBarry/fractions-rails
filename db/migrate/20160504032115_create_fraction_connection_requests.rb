class CreateFractionConnectionRequests < ActiveRecord::Migration
  def change
    create_table :fraction_connection_requests do |t|
      t.integer :requester_id, null: false
      t.integer :requestee_id, null: false

      t.string :offer, null: false

      t.timestamps null: false
    end
    add_index :fraction_connection_requests, [:requester_id, :requestee_id], unique: true, name: 'index_fraction_connection_requests_uniquely'
    add_index :fraction_connection_requests, :requestee_id
  end
end
