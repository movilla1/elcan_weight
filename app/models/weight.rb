# == Schema Information
#
# Table name: weights
#
#  id         :integer          not null, primary key
#  weight     :string(255)
#  truck_id   :integer
#  axis       :integer
#  complete   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  raw_data   :string(255)
#  device_id  :integer
#
# Indexes
#
#  index_weights_on_truck_id  (truck_id)
#  index_weights_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (truck_id => trucks.id)
#  fk_rails_...  (user_id => users.id)
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
  def self.by_date_and_truck(truck_id, date_start, date_end)
    includes(truck: [:users])
      .where(truck_id: truck_id, "weights.created_at": date_start..date_end)
      .group("DATE_FORMAT(weights.created_at, '%Y-%m-%d')")
      .sum(:weight)
  end

  def self.by_date_and_user(user_id, date_start, date_end)
    includes(:user)
      .where(user_id: user_id, "weights.created_at": date_start..date_end)
      .group("DATE_FORMAT(weights.created_at, '%Y-%m-%d')")
      .sum(:weight)
  end
end
