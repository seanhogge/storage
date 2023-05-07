class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.belongs_to :bin, null: false, foreign_key: true
      t.string :name
      t.integer :condition

      t.timestamps
    end
  end
end
