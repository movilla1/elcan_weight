# == Schema Information
#
# Table name: tag_positions
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  device_id  :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tag_positions_on_device_id  (device_id)
#  index_tag_positions_on_tag_id     (tag_id)
#

class TagPosition < ActiveRecord::Base
  belongs_to :tag
  belongs_to :device
end
