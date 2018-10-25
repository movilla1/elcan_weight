# frozen_string_literal: true

# This class generates the reports for the system, it gets the data "condensed"
# a view and a controller will be required to display the results.
class ReportManager
  def create_report_by_user(user_id)
    rows = []
    driver = User.find(user_id)
    driver.trucks.each do |truck|
      thisrow = get_condensed_truck_row(truck, user)
      rows << thisrow
    end
    rows
  end

  def create_report_by_truck(truck_id)
    rows = []
    truck = Truck.find(truck_id)
    truck.users.each do |user|
      thisrow = get_condensed_user_row(user, truck)
      rows << thisrow
    end
    rows
  end

  def get_condensed_truck_row(truck, user)
    truck_id = truck.id
    driver = "#{user.name} #{user.lastname}"
    truck_str = "#{truck_id} #{truck.license}"
    thisrow = { driver: driver, truck: truck_str }
    thisrow[:weights] = get_row_weights(truck_id, user_id)
    thisrow
  end

  def get_condensed_user_row(user, truck)
  end

  def get_row_weights(truck_id, user_id)
    result = []
    weights = Weight.where(truck_id: truck_id, user_id: user_id)
    weights.each do |weight|
      result << { weight: weight.weight, date: weight.created_at }
    end
    result
  end
end
