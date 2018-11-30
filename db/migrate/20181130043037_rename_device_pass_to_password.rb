class RenameDevicePassToPassword < ActiveRecord::Migration
  def change
    rename_column :devices, :pass, :password
  end
end
