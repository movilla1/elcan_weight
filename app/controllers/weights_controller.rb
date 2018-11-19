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
      str = create_intrussion_record(data, device)
    else
      str = create_weight_record(data, device)
    end
    render json: str, status: 200
  end

  private

  def check_auth
    render json: 'FAIL', status: 401 and return if params[:auth] != '32'
  end

  def get_user_or_return(tag_uid)
    @user = User.find_with_tag(tag_uid)
    render raw: 'FAIL' and return if @user.blank?
  end

  def create_weight_record(data, device)
    card_uid, stamp_part, weight_part = data.split('*')
    get_user_or_return(card_uid)
    truck_id = @user.current_truck.id
    w = Weight.create(
      truck_id: truck_id,
      created_at: stamp_part,
      axis: device,
      weight: weight_part,
      device: device,
      user_id: @user.id,
      tag_bytes: card_uid
    )

    w.blank? ? 'FAIL' : 'OK'
  end

  def create_intrussion_record(data, device)
    card_uid, stamp_part = data.split('*')
    ir = Intrussion.create(
      attemp_date: stamp_part,
      tag: card_uid,
      device: device
    )
    ir.present? ? 'OK' : 'FAIL'
  end
end
