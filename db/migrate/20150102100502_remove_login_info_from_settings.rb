class RemoveLoginInfoFromSettings < ActiveRecord::Migration
  def change
    remove_column :settings, :ip, :string
    remove_column :settings, :port, :string
    remove_column :settings, :user, :string
    remove_column :settings, :pass, :string
  end
end
