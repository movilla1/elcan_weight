# frozen_string_literal: true

# This class generates the reports for the system, it gets the data "condensed"
# a view and a controller will be required to display the results.
class ReportManager
  def create_report_by_driver(user_id, start_date, end_date)
    rows = []
    driver = User.find(user_id)
    driver.trucks.each do |truck|
      thisrow = get_condensed_truck_row(truck, driver)
      rows << thisrow
    end
    rows
  end

  def create_report_by_truck(truck_id, date_start, date_end)
    rows = []
    truck = Truck.find(truck_id)
    truck.users.each do |user|
      thisrow = get_condensed_user_row(user, truck, date_start, date_end)
      rows << thisrow
    end
    rows
  end

  def get_condensed_truck_row(truck, user)
    driver = user.display_string
    truck_str = truck.display_string
    thisrow = { driver: driver, truck: truck_str }
    thisrow[:weights] = get_row_weights(truck.id, user.id)
    thisrow
  end

  def get_condensed_user_row(user, truck, date_start, date_end)
    rows = []
    return false if date_start.blank? || date_end.blank?
    weights = Weight.for_truck_and_date_range(truck.id, date_start, date_end)
    weights.each do |weight_row|
      rows << get_weight_hash(user.display_string, truck.display_string,
                              weight_row)
    end
    rows
  end

  def get_weight_hash(driver, truck_str, weight)
    {
      driver: driver,
      truck: truck_str,
      weight: weight.weight,
      date: weight.created_at,
      in_out: weight.device
    }
  end

  def get_row_weights(truck_id, user_id)
    result = []
    weights = Weight.where(truck_id: truck_id, user_id: user_id)
    weights.each do |weight|
      result << { weight: weight.weight, date: weight.created_at,
                  in_out: weight.device }
    end
    result
  end
end
