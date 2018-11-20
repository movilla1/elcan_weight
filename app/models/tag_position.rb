class TagPosition < ActiveRecord::Base
  belongs_to :tag
  belongs_to :device
end
