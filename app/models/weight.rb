# == Schema Information
#
# Table name: weights
#
#  id            :integer          not null, primary key
#  weight        :string(255)
#  truck_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  raw_data      :string(255)
#  device_id     :integer
#  second_weight :string(255)
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
    joins(:user)
      .joins(:truck)
      .where(truck_id: truck_id, "weights.created_at": date_start..date_end)
      .group("DATE_FORMAT(weights.created_at, '%Y-%m-%d')")
      .sum("CAST(weight AS UNSIGNED) + CAST(second_weight AS UNSIGNED) - CAST(trucks.empty_weight AS UNSIGNED)")
  end

  def self.by_date_and_user(user_id, date_start, date_end)
    joins(:user)
      .joins(:truck)
      .where(user_id: user_id, "weights.created_at": date_start..date_end)
      .group("DATE_FORMAT(weights.created_at, '%Y-%m-%d')")
      .sum("CAST(weight AS UNSIGNED) + CAST(second_weight AS UNSIGNED) - CAST(trucks.empty_weight AS UNSIGNED)")
  end

  def self.grouped_by_driver(start_date, end_date)
    joins(:user)
      .joins(:truck)
      .where("weights.created_at": start_date..end_date)
      .group(:user_id)
      .sum("CAST(weight AS UNSIGNED) + CAST(second_weight AS UNSIGNED) - CAST(trucks.empty_weight AS UNSIGNED)")
  end
end
