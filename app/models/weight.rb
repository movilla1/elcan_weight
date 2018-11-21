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
#  device     :string
#  tag_bytes  :string
#

class Weight < ActiveRecord::Base
  belongs_to :truck
  belongs_to :user

  scope :for_truck_and_date_range, ->(truck_id, date_start, date_end) {
    where(
      created_at: [date_start..date_end],
      truck_id: truck_id
    )
  }
end
