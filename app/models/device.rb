# frozen_string_literal: true
# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  uid        :string
#  net_addr   :string
#  username   :string
#  pass       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  in_out     :boolean
#  name       :string
#

class Device < ActiveRecord::Base
  extend FriendlyId
  friendly_id :uid, use: :slugged

  has_many :tags, through: :tag_positions
  has_many :tag_positions
  has_many :intrussions

  accepts_nested_attributes_for :tag_positions

  def to_s
    uid
  end
end
