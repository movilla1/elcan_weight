# frozen_string_literal: true
# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  net_addr   :string(255)
#  username   :string(255)
#  password   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string(255)
#  in_out     :boolean
#  name       :string(255)
#

class Device < ActiveRecord::Base
  extend FriendlyId
  friendly_id :uid, use: :slugged

  has_many :tags, through: :tag_positions
  has_many :tag_positions
  has_many :intrussions

  accepts_nested_attributes_for :tag_positions, allow_destroy: true

  def to_s
    uid
  end
end
