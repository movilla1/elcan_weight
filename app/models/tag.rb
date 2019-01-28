# frozen_string_literal: true
# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  user_id    :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :tag_positions
  scope :active, -> { where(active: true) }

  def to_s
    id.to_s + " - " + uid
  end
end
