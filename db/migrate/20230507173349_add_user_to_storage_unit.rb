class AddUserToStorageUnit < ActiveRecord::Migration[7.0]
  def change
    add_reference :storage_units, :user, null: false, foreign_key: true
  end
end
