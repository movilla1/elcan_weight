class AddDeviceIdToIntrussion < ActiveRecord::Migration
  def change
    rename_column :intrussions, :device, :device_bytes
    add_reference :intrussions, :device, index: true, foreign_key: true
  end
end
