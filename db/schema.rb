# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 14) do

  create_table "clients", :force => true do |t|
    t.string "short_name",  :limit => 20, :default => "", :null => false
    t.string "name",                      :default => "", :null => false
    t.string "client_uri"
    t.text   "description"
  end

  add_index "clients", ["short_name"], :name => "short_name"
  add_index "clients", ["name"], :name => "name"

  create_table "images", :force => true do |t|
    t.string  "name",        :limit => 100, :default => "", :null => false
    t.string  "extension",   :limit => 10,  :default => "", :null => false
    t.string  "caption"
    t.integer "width",       :limit => 4
    t.integer "height",      :limit => 4
    t.integer "imageset_id",                :default => 0,  :null => false
  end

  create_table "imagesets", :force => true do |t|
    t.string  "title",       :limit => 100, :default => "", :null => false
    t.text    "description"
    t.integer "project_id",                 :default => 0,  :null => false
    t.integer "ord",         :limit => 4,   :default => 0,  :null => false
  end

  add_index "imagesets", ["title"], :name => "title"

  create_table "media", :force => true do |t|
    t.string "name"
  end

  create_table "projects", :force => true do |t|
    t.string  "name",                     :default => "", :null => false
    t.string  "uri"
    t.date    "start_date"
    t.date    "end_date"
    t.text    "description"
    t.integer "client_id",   :limit => 4, :default => 0,  :null => false
    t.integer "media_type",  :limit => 4, :default => 0,  :null => false
    t.integer "status",      :limit => 4, :default => 0,  :null => false
    t.integer "medium_id"
  end

  add_index "projects", ["name"], :name => "name"

  create_table "rights", :force => true do |t|
    t.string "name",       :limit => 100
    t.string "controller", :limit => 50,  :default => ""
    t.string "action",     :limit => 50,  :default => ""
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 100
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "sessions_session_id_index"

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], :name => "taggings_tag_id_index"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "tags_name_index"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
