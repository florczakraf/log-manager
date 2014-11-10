class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean
    add_column :users, :admin, :boolean
  end
end
