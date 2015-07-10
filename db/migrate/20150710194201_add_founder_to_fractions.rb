class AddFounderToFractions < ActiveRecord::Migration
  def change
    add_reference :fractions, :founder, polymorphic: true, index: true
  end
end
