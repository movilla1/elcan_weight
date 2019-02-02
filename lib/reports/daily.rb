# frozen_string_literal: true

require "reports/by_driver.rb"
module Reports
  # Gets a daily report for all drivers.
  # params:
  # - date_start: Datetime
  # - return:     Array
  class Daily
    def initialize(date_start)
      @date_start = date_start.beginning_of_day
      @date_end = date_start.end_of_day
    end

    def report
      rows = []
      drivers = User.by_role("driver").all.to_a
      drivers.each do |usr|
        rpt_manager = ByDriver.new(usr.id, @date_start, @date_end)
        result = rpt_manager.report
        rows << result if result.present?
      end
      return false if rouws.count < 1
      rows
    end
  end
end
