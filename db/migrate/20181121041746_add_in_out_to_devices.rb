# frozen_string_literal: true

class AddInOutToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :in_out, :boolean
  end
end
