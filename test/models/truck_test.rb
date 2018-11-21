# == Schema Information
#
# Table name: trucks
#
#  id         :integer          not null, primary key
#  license    :string
#  purchased  :date
#  capacity   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean
#

require 'test_helper'

class CamioneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
