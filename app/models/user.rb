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

  scope :current_truck, -> { trucks.order(created_at: :DESC).first }

  def self.find_with_tag(tagid)
    tag = Tag.find_by(id: tagid)
    tag.user if tag.present?
  end

  def display_string
    "#{nombre} #{apellido}"
  end

  def to_s
    display_string
  end
end
