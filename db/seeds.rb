# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.development?
  admin = User.create!(
    email: "admin@example.com", password: "password", password_confirmation: "password",
    nombre: "admin", legajo: "1", username: "admin"
  )
  driver1 = User.create!(
    email: "user1@example.com", password: "entrada", password_confirmation: "entrada",
    nombre: "camionero1", legajo: "12345", username: "camionero1"
  )
  driver2 = User.create!(
    email: "user2@example.com", password: "entrada", password_confirmation: "entrada",
    nombre: "camionero2", legajo: "12346", username: "camionero2"
  )
  driver3 = User.create!(
    email: "user3@example.com", password: "entrada", password_confirmation: "entrada",
    nombre: "camionero3", legajo: "12347", username: "camionero3"
  )
  Truck.create!(
    license: "ODK680", capacity: 2000, active: true,
    empty_weight: 1700, purchased: "2014-08-10"
  )
  Truck.create!(
    license: "LCM123", capacity: 1900, active: true,
    empty_weight: 1500, purchased: "2015-05-10"
  )
  Truck.create!(
    license: "MAE432", capacity: 2100, active: true,
    empty_weight: 1750, purchased: "2016-01-20"
  )

  Role.create!(user_id: admin.id, role: 3)
  Role.create!(user_id: driver1.id, role: 0)
  Role.create!(user_id: driver2.id, role: 0)
  Role.create!(user_id: driver3.id, role: 0)
  Device.create!(
    uid: "4ccfb0", net_addr: "192.168.25.108", username: "remot",
    pass: "elcanAdmin!", in_out: false, name: "bascula-antigua"
  )
  Device.create!(
    uid: "4ccfb1", net_addr: "192.168.25.109", username: "remot",
    pass: "elcanAdmin!", in_out: true, name: "bascula-nueva"
  )
  Tag.create!(uid: "800946d5", user_id: driver1.id, active: true)
  Tag.create!(uid: "968df448", user_id: driver2.id, active: true)
end
