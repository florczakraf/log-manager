class FixViolationColumnName < ActiveRecord::Migration
  def change
    rename_column :violations, :type, :type_name
  end
end
