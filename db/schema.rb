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

ActiveRecord::Schema.define(version: 2021_11_14_232140) do

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.boolean "is_public"
    t.datetime "created_at"
    t.integer "post_id"
    t.integer "from_user_id"
    t.integer "from_user_nickname"
    t.integer "to_user_id"
    t.integer "to_comment_id"
    t.index ["from_user_id"], name: "index_comments_on_from_user_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["to_comment_id"], name: "index_comments_on_to_comment_id"
    t.index ["to_user_id"], name: "index_comments_on_to_user_id"
  end

  create_table "group_chats", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.integer "user_id"
    t.index ["group_id"], name: "index_group_chats_on_group_id"
    t.index ["user_id"], name: "index_group_chats_on_user_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "status"
    t.text "intro"
    t.integer "group_id"
    t.integer "user_id"
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post_id"
    t.index ["post_id"], name: "index_groups_on_post_id"
  end

  create_table "nicknames", force: :cascade do |t|
    t.string "name"
  end

  create_table "post_user_nicknames", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.integer "nickname_id", null: false
    t.index ["post_id"], name: "index_post_user_nicknames_on_post_id"
    t.index ["user_id"], name: "index_post_user_nicknames_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.date "start"
    t.date "end"
    t.integer "next_nickname_id", default: 1
    t.integer "low_number"
    t.integer "high_number"
    t.string "tag1"
    t.string "tag2"
    t.string "tag3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "school"
    t.string "degree"
    t.string "major"
    t.integer "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "tags", id: false, force: :cascade do |t|
    t.string "name"
    t.integer "freq"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_token"
    t.string "google_refresh_token"
  end

end
