class CreateTagPositions < ActiveRecord::Migration
  def change
    create_table :tag_positions do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :device, index: true, foreign_key: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
