class CreateBins < ActiveRecord::Migration[7.0]
  def change
    create_table :bins do |t|
      t.belongs_to :storage_unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
