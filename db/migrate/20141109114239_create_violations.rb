class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.string :date
      t.string :type
      t.integer :player_id
      t.string :details
      t.string :ip
      t.integer :server_id

      t.timestamps
    end
  end
end
