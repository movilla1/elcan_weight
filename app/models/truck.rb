# frozen_string_literal: true

class Truck < ActiveRecord::Base
  has_and_belongs_to_many :users

  scope :active, -> { where(active: true) }
end
