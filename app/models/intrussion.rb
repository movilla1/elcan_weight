# == Schema Information
#
# Table name: intrussions
#
#  id           :integer          not null, primary key
#  attemp_date  :datetime
#  tag          :string(255)
#  device_bytes :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  device_id    :integer
#
# Indexes
#
#  index_intrussions_on_device_id  (device_id)
#
# Foreign Keys
#
#  fk_rails_...  (device_id => devices.id)
#

class Intrussion < ActiveRecord::Base
  belongs_to :device
end
