class AddDeviceToWeights < ActiveRecord::Migration
  def change
    add_column :weights, :device, :string
  end
end
