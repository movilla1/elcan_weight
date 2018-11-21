class ChangeWeights < ActiveRecord::Migration
  def change
    remove_column :weights, :device
    remove_column :weights, :tag_bytes
    add_column :weights, :raw_data, :string
    add_column :weights, :device_id, :integer, index: true, foreign_key: true
  end
end
