# frozen_string_literal: true

require "reports/report_base"

module Reports
  # Creates a report by truck
  class ByTruck < ReportBase
    def initialize(truck_id, date_start, date_end)
      @truck_id = truck_id
      @truck = Truck.find(@truck_id)
      @date_start = Date.strptime(date_start, "%Y-%m-%d")
      @date_end = Date.strptime(date_end, "%Y-%m-%d")
    end

    def report
      ret_rows = []
      @truck.users.each do |usr|
        rows = Weight.where(user_id: usr.id,
          created_at: @date_start.beginning_of_day..@date_end.end_of_day,
          truck_id: @truck_id)
        weights, total_weight = assemble_rows(rows)
        ret_rows << {
          driver: usr,
          truck: rows.first.try(:truck),
          total_weight: total_weight,
          weights: weights
        }
      end
      ret_rows
    end
  end
end
