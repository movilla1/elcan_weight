# frozen_string_literal: true

module Reports
  # This class gets the performance data
  class DriverPerformance
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def report
      [@start_date, @end_date, sum_rows]
    end

    private

    def sum_rows
      Weight
        .includes(:user)
        .where("weights.created_at": @start_date..@end_date)
        .group(:user)
        .sum(:weight)
    end
  end
end
