# frozen_string_literal: true

class Tag < ActiveRecord::Base
  belongs_to :user
end
