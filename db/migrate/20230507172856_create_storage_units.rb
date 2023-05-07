class CreateStorageUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :storage_units do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website
      t.string :unit

      t.timestamps
    end
  end
end
