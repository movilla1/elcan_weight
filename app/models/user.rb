# frozen_string_literal: true

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable
  has_many :trucks, through: :weights
  has_many :weights
  has_many :tags

  def find_with_tag(tag_id)
    tag = tags.find_by(tag_id: tag_id)
    tag.user if tag.present?
  end

  def display_string
    "#{nombre} #{apellido}"
  end

  def to_s
    display_string
  end
end
