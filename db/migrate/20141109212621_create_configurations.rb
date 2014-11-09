class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :ip
      t.string :port
      t.string :user
      t.string :pass

      t.timestamps
    end
  end
end
