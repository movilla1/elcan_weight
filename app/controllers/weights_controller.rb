# frozen_string_literal: true

# Weight controller for the app, it also handles the rfid devices.
class WeightsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create_from_rfid]
  before_filter :check_auth, only: [:create_from_rfid]
  TAG_ID_POSITION = 0
  TIME_POSITION_START = 1
  TIME_POSITION_END = 4
  WEIGHT_START = 5
  WEIGHT_END = 12
  CARD_UID_START = 0
  CARD_UID_END = 3

  def create_from_rfid
    data = params[:data]
    device = params[:device]
    intrussion = params[:intrussion]
    str = if intrussion.present?
            create_intrussion_record(data, device)
          else
            create_weight_record(data, device)
          end
    render json: str, status: 200
  end

  private

  def check_auth
    render(json: "FAIL", status: 401) && return if params[:auth] != "32"
  end

  def get_user_or_return(tag_uid)
    @user = User.find_with_tag(tag_uid)
    render(raw: "FAIL") && return if @user.blank?
  end

  def create_weight_record(data, device_uid)
    card_uid, stamp_part, first_weight, second_weight = data.split("*")
    get_user_or_return(card_uid)
    truck_id = @user.current_truck.id
    device = Device.find_by_uid(device_uid)
    second_weight = second_weight.presence || "000000"
    w = Weight.create(
      truck_id: truck_id,
      created_at: stamp_part,
      weight: first_weight,
      device_id: device.id,
      user_id: @user.id,
      raw_data: data,
      second_weight: second_weight
    )
    w.blank? ? "FAIL" : "OK"
  end

  def create_intrussion_record(data, device_uid)
    card_uid, stamp_part = data.split("*")
    device = Device.find_by_uid(device_uid)
    ir = Intrussion.create(
      attemp_date: stamp_part,
      tag: card_uid,
      device_bytes: device_uid,
      device_id: device.try(:id)
    )
    ir.present? ? "OK" : "FAIL"
  end
end
