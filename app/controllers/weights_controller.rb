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
    if intrussion.present?
      create_intrussion_record(data, device)
    else
      create_weight_record(data, device)
    end
    render json: 'OK', status: 200
  end

  private

  def check_auth
    render json: 'FAIL', status: 401 and return if params[:auth] != '32'
  end

  def get_user_or_return(tag_id)
    @user = User.find_with_tag(tag_id)
    render raw: 'FAIL' and return if @user.blank?
  end

  def create_weight_record(data, device)
    time_part = data[TIME_POSITION_START, TIME_POSITION_END]
    weight = data[WEIGHT_START, WEIGHT_END]
    get_user_or_return(data[TAG_ID_POSITION])
    truck_id = @user.current_truck.id
    Weight.create(truck_id: truck_id, created_at: time_part,
                  eje: device, peso: weight)
  end

  def create_intrussion_record(data, device)
    time_part = data[CARD_UID_END, CARD_UID_END + 4]
    card_uid_bin = data[CARD_UID_START, CARD_UID_END]
    card_uid = []
    card_uid_bin.each_byte do |c|
      card_uid.push format("%02X", c)
    end
    Intrussion.create(attemp_date: time_part, tag: card_uid.join("-"), device: device)
  end
end
