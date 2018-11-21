# == Schema Information
#
# Table name: trucks_users
#
#  user_id  :integer          not null
#  truck_id :integer          not null
#

class TrucksUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
end
