# frozen_string_literal: true

require "reports/by_driver.rb"
module Reports
  # Gets a daily report for all drivers.
  # params:
  # - date_start: Datetime
  # - date_end:   Datetime
  # - return:     Array
  class Daily
    def initialize(date_start, date_end)
      @date_start = date_start
      @date_end = date_end
    end

    def report
      rows = []
      drivers = User.by_role("driver").all.to_a
      drivers.each do |usr|
        rpt_manager = ByDriver.new(usr.id, @date_start, @date_end)
        rows << rpt_manager.report
      end
      rows
    end
  end
end
