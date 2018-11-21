# == Schema Information
#
# Table name: weights
#
#  id         :integer          not null, primary key
#  weight     :string
#  truck_id   :integer
#  axis       :integer
#  complete   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  raw_data   :string
#  device_id  :integer
#
# Indexes
#
#  index_weights_on_truck_id  (truck_id)
#  index_weights_on_user_id   (user_id)
#

class Weight < ActiveRecord::Base
  belongs_to :truck
  belongs_to :user
  belongs_to :device

  scope :for_truck_and_date_range, ->(truck_id, date_start, date_end) {
    where(
      created_at: [date_start..date_end],
      truck_id: truck_id
    )
  }
end
