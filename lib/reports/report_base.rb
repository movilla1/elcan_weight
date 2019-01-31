module Reports
  # Basic functions for all weight reports
  class ReportBase
    def assemble_rows(input)
      out = []
      total_weight = 0
      input.each do |row|
        weight = row.weight.to_f + row.second_weight.to_f - row.truck.empty_weight.to_f
        out << {
          input: row,
          measured_weight: weight,
          weight_start: row.created_at
        }
        total_weight += weight if weight.class != String
      end
      [out, total_weight]
    end
  end
end
