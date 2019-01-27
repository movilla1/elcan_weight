module Reports
  # Basic functions for all weight reports
  class ReportBase
    def get_in_out_from_rows(rows)
      input = rows.select { |x| x.axis == 1 }
      input = input.sort_by &:created_at
      output = rows.select { |x| x.axis == 2 }
      output = output.sort_by &:created_at
      [input, output]
    end

    def assemble_rows(input, output)
      out = []
      total_weight = 0
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
        total_weight += weight if weight.class != String
      end
      [out, total_weight]
    end

    def find_matching_out_row(output, row)
      out_row = output.find do |x|
        x.created_at - row.created_at <= 1.minutes &&
          x.truck_id == row.truck_id
      end
      out_row
    end
  end
end
