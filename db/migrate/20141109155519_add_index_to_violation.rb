class AddIndexToViolation < ActiveRecord::Migration
  def change
    add_index(:violations, [:date, :type, :player_id, :details, :ip, :server_id], unique: true, name: 'my_index')
  end
end
