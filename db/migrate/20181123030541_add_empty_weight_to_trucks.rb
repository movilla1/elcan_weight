class AddEmptyWeightToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :empty_weight, :numeric
  end
end
