# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190131120349) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "net_addr",   limit: 255
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "slug",       limit: 255
    t.boolean  "in_out"
    t.string   "name",       limit: 255
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "intrussions", force: :cascade do |t|
    t.datetime "attemp_date"
    t.string   "tag",          limit: 255
    t.string   "device_bytes", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "device_id",    limit: 4
  end

  add_index "intrussions", ["device_id"], name: "index_intrussions_on_device_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "tag_positions", force: :cascade do |t|
    t.integer  "tag_id",     limit: 4
    t.integer  "device_id",  limit: 4
    t.integer  "position",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "on_device"
  end

  add_index "tag_positions", ["device_id"], name: "index_tag_positions_on_device_id", using: :btree
  add_index "tag_positions", ["tag_id"], name: "index_tag_positions_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.integer  "user_id",    limit: 4
    t.boolean  "active"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "trucks", force: :cascade do |t|
    t.string   "license",      limit: 255
    t.date     "purchased"
    t.float    "capacity",     limit: 24
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "active"
    t.decimal  "empty_weight",             precision: 10
  end

  create_table "trucks_users", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 4, null: false
    t.integer "truck_id", limit: 4, null: false
  end

  add_index "trucks_users", ["truck_id", "user_id"], name: "index_trucks_users_on_truck_id_and_user_id", using: :btree
  add_index "trucks_users", ["user_id", "truck_id"], name: "index_trucks_users_on_user_id_and_truck_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "nombre",                 limit: 255
    t.string   "apellido",               limit: 255
    t.string   "legajo",                 limit: 255
    t.string   "username",               limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "slug",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "weights", force: :cascade do |t|
    t.string   "weight",        limit: 255
    t.integer  "truck_id",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",       limit: 4
    t.string   "raw_data",      limit: 255
    t.integer  "device_id",     limit: 4
    t.string   "second_weight", limit: 255
  end

  add_index "weights", ["truck_id"], name: "index_weights_on_truck_id", using: :btree
  add_index "weights", ["user_id"], name: "index_weights_on_user_id", using: :btree

  add_foreign_key "intrussions", "devices"
  add_foreign_key "roles", "users"
  add_foreign_key "tag_positions", "devices"
  add_foreign_key "tag_positions", "tags"
  add_foreign_key "tags", "users"
  add_foreign_key "weights", "trucks"
  add_foreign_key "weights", "users"
end
