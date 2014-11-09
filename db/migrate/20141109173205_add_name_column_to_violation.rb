class AddNameColumnToViolation < ActiveRecord::Migration
  def change
    add_column :violations, :name, :string
  end
end
