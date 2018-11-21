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
#  device     :string
#  tag_bytes  :string
#

require 'test_helper'

class PesajeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
