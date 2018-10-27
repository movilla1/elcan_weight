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
