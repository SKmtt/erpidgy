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

ActiveRecord::Schema.define(version: 20180727145656) do

  create_table "characters", force: :cascade do |t|
    t.string  "name"
    t.string  "surname"
    t.text    "description"
    t.date    "birth"
    t.integer "user_id"
    t.string  "status",        default: "pending"
    t.string  "profile_image"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "character_id"
    t.string   "name"
    t.string   "description"
    t.string   "img_location"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["character_id"], name: "index_locations_on_character_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.string   "scope"
    t.integer  "character_id"
    t.integer  "room_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["character_id"], name: "index_messages_on_character_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.text    "name"
    t.text    "description"
    t.text    "resources_url"
    t.text    "created_at",                   null: false
    t.text    "updated_at",                   null: false
    t.text    "parametrized"
    t.integer "is_open"
    t.integer "location_id"
    t.boolean "is_active",     default: true
    t.index ["location_id"], name: "index_rooms_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "username",                              null: false
    t.boolean  "active",                 default: true, null: false
    t.datetime "ban"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "current_character_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.integer  "active_room_id"
    t.index ["active_room_id"], name: "index_users_on_active_room_id"
    t.index ["current_character_id"], name: "index_users_on_current_character_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_rooms", force: :cascade do |t|
    t.string   "status"
    t.boolean  "can_add_place"
    t.boolean  "open"
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["room_id"], name: "index_users_rooms_on_room_id"
    t.index ["user_id"], name: "index_users_rooms_on_user_id"
  end

end
