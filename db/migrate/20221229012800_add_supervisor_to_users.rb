class AddSupervisorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :supervisor, null: true, foreign_key: { to_table: :users }
  end
end
