class RemoveDevicePositionFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :device_position
  end
end
