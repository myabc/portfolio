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

ActiveRecord::Schema.define(:version => 6) do

  create_table "assets", :force => true do |t|
    t.integer "parent_id"
    t.string  "content_type"
    t.string  "filename"
    t.string  "thumbnail"
    t.integer "size"
    t.integer "width"
    t.integer "height"
  end

  create_table "assets_projects", :id => false, :force => true do |t|
    t.integer "asset_id"
    t.integer "project_id"
  end

  add_index "assets_projects", ["project_id"], :name => "index_assets_projects_on_project_id"
  add_index "assets_projects", ["asset_id"], :name => "index_assets_projects_on_asset_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",     :default => false
    t.integer  "position"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "status",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "typus_users", :force => true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "status",          :default => false
    t.boolean  "admin",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
