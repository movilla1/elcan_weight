# frozen_string_literal: true
# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Role < ActiveRecord::Base
  belongs_to :user
  enum role: %i[driver operator admin sysadmin]
end
