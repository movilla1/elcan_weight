class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_uid
      t.references :user, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
