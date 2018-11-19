class AddTagBytesToWeights < ActiveRecord::Migration
  def change
    add_column :weights, :tag_bytes, :string
  end
end
