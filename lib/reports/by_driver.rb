# frozen_string_literal: true

module Reports
  # Creates a report by driver, with an input and output row
  class ByDriver
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
      @weights = assemble_rows(input, output)
      {
        driver: @driver,
        truck: input.first.try(:truck).try(:display_string),
        weights: @weights
      }
    end

    private

    def get_in_out_from_rows(rows)
      input = rows.select { |x| x.axis == 1 }
      input = input.sort_by &:created_at
      output = rows.select { |x| x.axis == 2 }
      output = output.sort_by &:created_at
      [input, output]
    end

    def assemble_rows(input, output)
      out = []
      input.each do |row|
        out_row = find_matching_out_row(output, row)
        weight = if out_row.present? && row.present? && row.weight.present?
                   row.weight.to_f + out_row.weight.to_f - row.truck.empty_weight.to_f
                 else
                   I18n.t("incomplete")
                 end
        out << {
          input: row,
          output: out_row,
          measured_weight: weight,
          weight_start: row.created_at
        }
      end
      out
    end

    def find_matching_out_row(output, row)
      out_row = output.find do |x|
        x.created_at - row.created_at <= 5.minutes &&
          x.truck_id == row.truck_id
      end
      out_row
    end
  end
end
