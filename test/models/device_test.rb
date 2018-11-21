# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  uid        :string
#  net_addr   :string
#  username   :string
#  pass       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  in_out     :boolean
#  name       :string
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
