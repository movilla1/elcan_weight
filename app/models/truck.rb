# frozen_string_literal: true

class Truck < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :weights

  scope :active, -> { where(active: true) }

  def display_string
    "##{id} - #{license}"
  end

  def to_s
    display_string
  end
end
