class AddOnDeviceToTagPositions < ActiveRecord::Migration
  def change
    add_column :tag_positions, :on_device, :boolean
  end
end
