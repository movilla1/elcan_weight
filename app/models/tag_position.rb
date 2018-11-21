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

class TagPosition < ActiveRecord::Base
  belongs_to :tag
  belongs_to :device
end
