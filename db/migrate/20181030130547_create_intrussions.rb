class CreateIntrussions < ActiveRecord::Migration
  def change
    create_table :intrussions do |t|
      t.timestamp :attemp_date
      t.string :tag
      t.string :device

      t.timestamps null: false
    end
  end
end
