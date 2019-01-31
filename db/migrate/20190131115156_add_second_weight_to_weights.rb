# frozen_string_literal: true

class AddSecondWeightToWeights < ActiveRecord::Migration
  def up
    add_column :weights, :second_weight, :string
    Weight.find_each do |weight|
      second = Weight.where.not(id: weight.id).find_by(created_at: weight.created_at) # Find another record with the same time
      ret = weight.update(second_weight: second.weight)
      second.destroy if ret.present?
    end
  end

  def down
    remove_column :weights, :second_weight # partially reversed transaction.
  end
end
