class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :guid
      t.boolean :banned

      t.timestamps
    end
  end
end
