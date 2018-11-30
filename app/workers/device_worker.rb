# frozen_string_literal: true

# This worker is to perform device tasks asynchronously.
class DeviceWorker
  def self.add_tag(device_id, tag_uid, position)
    device = Device.find(device_id)
    op = send_to_device(device, tag_uid, position)
    op == 200 # 200 is the http "ok" answer
  end

  def self.remove_tag(device_id, tag_uid, position)
    device = Device.find(device_id)
    op = send_to_device(device, tag_uid, position, true)
    op == 200 # 200 is the http "ok" answer
  end

  # API for tag management expects a user and password to allow to proceed,
  # plus the following:
  # ti: Tag ID in hex
  # po: Position in hex too.
  # rm: on or off indicating if the operation is a remove or add (on removes,
  #     off adds)
  def self.send_to_device(device, tag_uid, position, remove = nil)
    response = HTTParty.post(
      device.net_addr.to_s + "/receive/tag",
      {
        usr: device.user,
        pwd: device.pass,
        ti: tag_uid,
        po: position,
        rm: remove.blank? ? "off" : "on"
      }
    )
    response.code
  end
end
