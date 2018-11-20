class AddSlugToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :slug, :string
  end
end
