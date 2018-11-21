# == Schema Information
#
# Table name: weights
#
#  id         :integer          not null, primary key
#  weight     :string
#  truck_id   :integer
#  axis       :integer
#  complete   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  raw_data   :string
#  device_id  :integer
#
# Indexes
#
#  index_weights_on_truck_id  (truck_id)
#  index_weights_on_user_id   (user_id)
#

require 'test_helper'

class PesajeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
