# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100415015743) do

  create_table "assets", :force => true do |t|
    t.string   "asset_file_name",    :null => false
    t.integer  "asset_file_size"
    t.string   "asset_content_type"
    t.datetime "asset_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["asset_content_type"], :name => "index_assets_on_asset_content_type"

  create_table "cities", :force => true do |t|
    t.string   "name",         :limit => 100, :null => false
    t.string   "url_friendly", :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["url_friendly"], :name => "index_cities_on_url_friendly", :unique => true

  create_table "countries", :force => true do |t|
    t.string   "name",              :limit => 100, :null => false
    t.string   "url_friendly",      :limit => 100, :null => false
    t.string   "code",              :limit => 50
    t.string   "flag_file_name"
    t.integer  "flag_file_size"
    t.string   "flag_content_type"
    t.datetime "flag_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["code"], :name => "index_countries_on_code", :unique => true
  add_index "countries", ["url_friendly"], :name => "index_countries_on_url_friendly", :unique => true

  create_table "distributors", :force => true do |t|
    t.string   "name",           :null => false
    t.string   "url_friendly",   :null => false
    t.integer  "postal_code_id"
    t.integer  "country_id",     :null => false
    t.string   "phone_number"
    t.string   "website_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "distributors", ["country_id"], :name => "index_distributors_on_country_id"
  add_index "distributors", ["postal_code_id"], :name => "index_distributors_on_postal_code_id"
  add_index "distributors", ["url_friendly"], :name => "index_distributors_on_url_friendly", :unique => true

  create_table "makes", :force => true do |t|
    t.string   "name",         :limit => 150, :null => false
    t.string   "key_name",     :limit => 150, :null => false
    t.string   "url_friendly", :limit => 150, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "makes", ["key_name"], :name => "index_makes_on_key_name", :unique => true
  add_index "makes", ["url_friendly"], :name => "index_makes_on_url_friendly", :unique => true

  create_table "postal_code_types", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postal_codes", :force => true do |t|
    t.string   "code",                :limit => 25, :null => false
    t.integer  "city_id",                           :null => false
    t.integer  "state_id",                          :null => false
    t.integer  "postal_code_type_id",               :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postal_codes", ["city_id"], :name => "index_postal_codes_on_city_id"
  add_index "postal_codes", ["code", "city_id", "state_id"], :name => "by_code", :unique => true
  add_index "postal_codes", ["code"], :name => "index_postal_codes_on_code", :unique => true
  add_index "postal_codes", ["postal_code_type_id"], :name => "index_postal_codes_on_postal_code_type_id"
  add_index "postal_codes", ["state_id"], :name => "index_postal_codes_on_state_id"

  create_table "redirects", :force => true do |t|
    t.string   "old_url",    :null => false
    t.string   "new_url",    :null => false
    t.string   "http_code",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redirects", ["old_url"], :name => "index_redirects_on_old_url", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name",        :limit => 100, :null => false
    t.string   "key_name",    :limit => 100, :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["key_name"], :name => "index_roles_on_key_name", :unique => true

  create_table "states", :force => true do |t|
    t.string   "name",         :limit => 100, :null => false
    t.string   "url_friendly", :limit => 100, :null => false
    t.string   "code",         :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["code"], :name => "index_states_on_code"
  add_index "states", ["url_friendly"], :name => "index_states_on_url_friendly", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "users_roles", :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "role_id", :null => false
  end

  add_index "users_roles", ["role_id"], :name => "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id", "role_id"], :name => "by_role", :unique => true
  add_index "users_roles", ["user_id"], :name => "index_users_roles_on_user_id"

end
