# frozen_string_literal: true
# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  tag_uid    :string
#  user_id    :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#

class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :tag_positions
  scope :active, -> { where(active: true) }
end
