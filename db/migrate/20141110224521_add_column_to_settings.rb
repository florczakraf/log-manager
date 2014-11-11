class AddColumnToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :last_update, :datetime
  end
end
