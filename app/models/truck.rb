# frozen_string_literal: true

class Truck < ActiveRecord::Base
  has_many :users, through: :weights
  has_many :weights

  scope :active, -> { where(active: true) }

  def display_string
    "##{id} - #{license}"
  end

  def to_s
    display_string
  end
end
