class CreateMarks < ActiveRecord::Migration[7.0]
  def change
    create_table :marks do |t|
      t.integer :disposition
      t.references :markable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
