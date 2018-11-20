# frozen_string_literal: true

class Device < ActiveRecord::Base
  extend FriendlyId
  friendly_id :uid, use: :slugged

  has_many :tags, through: :tag_positions
  has_many :tag_positions
  accepts_nested_attributes_for :tag_positions

  def to_s
    uid
  end
end
