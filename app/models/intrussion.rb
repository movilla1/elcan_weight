# == Schema Information
#
# Table name: intrussions
#
#  id          :integer          not null, primary key
#  attemp_date :datetime
#  tag         :string
#  device      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Intrussion < ActiveRecord::Base
end
