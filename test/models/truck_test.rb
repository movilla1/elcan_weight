# == Schema Information
#
# Table name: trucks
#
#  id           :integer          not null, primary key
#  license      :string(255)
#  purchased    :date
#  capacity     :float(24)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  active       :boolean
#  empty_weight :decimal(10, )
#

require 'test_helper'

class CamioneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
