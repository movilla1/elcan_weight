# frozen_string_literal: true

class RemoveAxisAndCompleteFromWeights < ActiveRecord::Migration
  def change
    remove_column :weights, :axis
    remove_column :weights, :complete
  end
end
