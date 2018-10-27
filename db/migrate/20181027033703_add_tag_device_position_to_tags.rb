class AddTagDevicePositionToTags < ActiveRecord::Migration
  def change
    add_column :tags, :device_position, :integer
  end
end
