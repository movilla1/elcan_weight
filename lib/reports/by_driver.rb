# frozen_string_literal: true
require "reports/report_base"

module Reports
  # Creates a report by driver, with an input and output row
  class ByDriver < ReportBase
    attr_reader :rows
    def initialize(driver_id, start_date, end_date)
      @driver = User.find(driver_id)
      @start_date = start_date
      @end_date = end_date
    end

    def report
      rows = Weight.where(
        user_id: @driver.id,
        created_at: @start_date..@end_date
      )
      input, output = get_in_out_from_rows(rows)
      weights, total_weight = assemble_rows(input, output)
      {
        driver: @driver,
        truck: input.first.try(:truck).try(:display_string),
        total_weight: total_weight,
        weights: weights
      }
    end
  end
end
