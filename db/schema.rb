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

ActiveRecord::Schema.define(version: 2019_07_05_051445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "channels", force: :cascade do |t|
    t.string "name", null: false
    t.text "topic"
    t.integer "server_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_channels_on_server_id"
  end

  create_table "dm_conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dm_memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "dm_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dm_id"], name: "index_dm_memberships_on_dm_id"
    t.index ["user_id", "dm_id"], name: "index_dm_memberships_on_user_id_and_dm_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "body", null: false
    t.integer "messagable_id", null: false
    t.string "messagable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["messagable_type", "messagable_id"], name: "index_messages_on_messagable_type_and_messagable_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "server_invites", force: :cascade do |t|
    t.string "code", null: false
    t.integer "uses", null: false
    t.integer "max_uses"
    t.datetime "expire_date"
    t.integer "server_id", null: false
    t.integer "inviter_id", null: false
    t.integer "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_server_invites_on_channel_id"
    t.index ["code"], name: "index_server_invites_on_code", unique: true
    t.index ["inviter_id"], name: "index_server_invites_on_inviter_id"
    t.index ["server_id"], name: "index_server_invites_on_server_id"
  end

  create_table "server_memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "nickname"
    t.integer "server_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_server_memberships_on_server_id"
    t.index ["user_id", "server_id"], name: "index_server_memberships_on_user_id_and_server_id", unique: true
  end

  create_table "servers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_servers_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "tag", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "session_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
    t.index ["tag"], name: "index_users_on_tag", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
