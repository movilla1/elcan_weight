# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nombre                 :string
#  apellido               :string
#  legajo                 :string
#  username               :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  slug                   :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable
  has_and_belongs_to_many :trucks
  has_many :roles
  has_many :weights
  has_many :tags
  accepts_nested_attributes_for :roles

  scope :by_role, ->(this_rol) { joins(:roles).where(roles: { role: this_rol }) }

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
