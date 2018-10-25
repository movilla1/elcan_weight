# frozen_string_literal: true

class TrucksUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
end
