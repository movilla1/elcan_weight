# frozen_string_literal: true
require "reports/report_base"

module Reports
  # Creates a report by driver, with an input and output row
  class ByDriver < ReportBase
    attr_reader :rows
    def initialize(driver_id, start_date, end_date)
      @driver = User.find(driver_id)
      @start_date = start_date.is_a?(String) ? Date.strptime(start_date, "%Y-%m-%d") : start_date
      @end_date = end_date.is_a?(String) ? Date.strptime(end_date, "%Y-%m-%d") : end_date
    end

    def report
      rows = Weight.where(
        user_id: @driver.id,
        created_at: @start_date..@end_date
      )
      first_row = rows.first
      weights, total_weight = assemble_rows(rows)
      return false if weights.blank?
      {
        driver: @driver,
        truck: first_row.try(:truck),
        total_weight: total_weight,
        weights: weights
      }
    end
  end
end
