# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  tag_uid    :string
#  user_id    :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
