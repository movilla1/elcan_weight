# == Schema Information
#
# Table name: intrussions
#
#  id           :integer          not null, primary key
#  attemp_date  :datetime
#  tag          :string
#  device_bytes :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  device_id    :integer
#
# Indexes
#
#  index_intrussions_on_device_id  (device_id)
#

require 'test_helper'

class IntrussionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
