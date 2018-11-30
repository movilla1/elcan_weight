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
# Foreign Keys
#
#  fk_rails_...  (device_id => devices.id)
#  fk_rails_...  (tag_id => tags.id)
#
class TagPosition < ActiveRecord::Base
  belongs_to :tag
  belongs_to :device
  after_create :store_tag_on_device
  before_destroy :remove_tag_from_device
  after_save :update_tag_on_device

  private

  def store_tag_on_device
    op = DeviceWorker.delay.add_tag(device, tag.uid, position)
    update_attributes(on_device: true) if op.present?
  end

  def remove_tag_from_device
    op = DeviceWorker.delay.remove_tag(device, tag.uid, position_was)
    update_attributes(on_device: false) if op.present?
  end

  def update_tag_on_device
    return unless position_changed?
    old_position = position_was
    new_position = position
    op1 = DeviceWorker.delay.remove_tag(device, tag.uid, old_position)
    op2 = DeviceWorker.delay.add_tag(device, tag.uid, new_position) if op1
    op1 & op2
  end
end
