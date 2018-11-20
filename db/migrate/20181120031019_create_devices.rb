class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :uid
      t.string :net_addr
      t.string :username
      t.string :pass

      t.timestamps null: false
    end
  end
end
