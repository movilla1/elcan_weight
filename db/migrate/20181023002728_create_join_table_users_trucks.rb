class CreateJoinTableUsersTrucks < ActiveRecord::Migration
  def change
    create_join_table :users, :trucks do |t|
      t.index [:user_id, :truck_id]
      t.index [:truck_id, :user_id]

      t.timestamps
    end
  end
end
