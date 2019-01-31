# == Schema Information
#
# Table name: weights
#
#  id            :integer          not null, primary key
#  weight        :string(255)
#  truck_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  raw_data      :string(255)
#  device_id     :integer
#  second_weight :string(255)
#
# Indexes
#
#  index_weights_on_truck_id  (truck_id)
#  index_weights_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (truck_id => trucks.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class PesajeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
