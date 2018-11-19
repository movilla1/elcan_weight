# frozen_string_literal: true

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable
  has_and_belongs_to_many :trucks
  has_many :weights
  has_many :tags

  def self.find_with_tag(tag_uid)
    tag = Tag.find_by(tag_uid: tag_uid.upcase)
    tag.user if tag.present?
  end

  def current_truck
    trucks.order(created_at: :DESC).first
  end

  def display_string
    "#{nombre} #{apellido}"
  end

  def to_s
    display_string
  end
end
