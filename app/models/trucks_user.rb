# == Schema Information
#
# Table name: trucks_users
#
#  user_id  :integer          not null
#  truck_id :integer          not null
#
# Indexes
#
#  index_trucks_users_on_truck_id_and_user_id  (truck_id,user_id)
#  index_trucks_users_on_user_id_and_truck_id  (user_id,truck_id)
#

class TrucksUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :truck
end
