# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  net_addr   :string(255)
#  username   :string(255)
#  pass       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string(255)
#  in_out     :boolean
#  name       :string(255)
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
