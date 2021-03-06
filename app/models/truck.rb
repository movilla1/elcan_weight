# frozen_string_literal: true
# == Schema Information
#
# Table name: trucks
#
#  id           :integer          not null, primary key
#  license      :string(255)
#  purchased    :date
#  capacity     :float(24)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  active       :boolean
#  empty_weight :decimal(10, )
#

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
