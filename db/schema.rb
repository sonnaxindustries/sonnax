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

ActiveRecord::Schema.define(:version => 20100506190934) do

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

  create_table "contacts", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "email",        :null => false
    t.string   "company",      :null => false
    t.string   "phone_number", :null => false
    t.text     "message",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["email"], :name => "index_contacts_on_email"

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
    t.string   "name",                   :null => false
    t.string   "url_friendly",           :null => false
    t.string   "phone_number"
    t.string   "website_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "email"
    t.boolean  "has_multiple_locations"
  end

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

  create_table "part_attribute_types", :force => true do |t|
    t.string   "name"
    t.string   "key_name",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "part_attribute_types", ["key_name"], :name => "index_part_attribute_types_on_key_name", :unique => true

  create_table "part_attributes", :force => true do |t|
    t.integer  "part_id",                :null => false
    t.integer  "part_attribute_type_id", :null => false
    t.string   "attr_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "part_attributes", ["part_attribute_type_id"], :name => "index_part_attributes_on_part_attribute_type_id"
  add_index "part_attributes", ["part_id"], :name => "index_part_attributes_on_part_id"

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

  create_table "product_lines", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "url_friendly",                   :null => false
    t.boolean  "is_active",    :default => true
    t.integer  "sort_order",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_lines", ["is_active"], :name => "index_product_lines_on_is_active"
  add_index "product_lines", ["url_friendly"], :name => "index_product_lines_on_url_friendly", :unique => true

  create_table "publication_authors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name",  :null => false
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publication_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name",         :limit => 150, :null => false
    t.string   "url_friendly", :limit => 150, :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_categories", ["parent_id"], :name => "index_publication_categories_on_parent_id"
  add_index "publication_categories", ["url_friendly"], :name => "index_publication_categories_on_url_friendly", :unique => true

  create_table "publication_categories_titles", :force => true do |t|
    t.integer  "publication_category_id", :null => false
    t.integer  "publication_title_id",    :null => false
    t.text     "description"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_categories_titles", ["publication_category_id", "publication_title_id"], :name => "by_category", :unique => true
  add_index "publication_categories_titles", ["publication_category_id"], :name => "index_publication_categories_titles_on_publication_category_id"
  add_index "publication_categories_titles", ["publication_title_id"], :name => "index_publication_categories_titles_on_publication_title_id"

  create_table "publication_titles", :force => true do |t|
    t.string   "title",            :null => false
    t.string   "url_friendly",     :null => false
    t.text     "description"
    t.string   "pdf_file_name"
    t.integer  "pdf_file_size"
    t.string   "pdf_content_type"
    t.datetime "pdf_updated_at"
    t.string   "volume_number"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles", ["url_friendly"], :name => "index_publication_titles_on_url_friendly", :unique => true

  create_table "publication_titles_authors", :force => true do |t|
    t.integer "publication_title_id",  :null => false
    t.integer "publication_author_id", :null => false
  end

  add_index "publication_titles_authors", ["publication_author_id"], :name => "index_publication_titles_authors_on_publication_author_id"
  add_index "publication_titles_authors", ["publication_title_id", "publication_author_id"], :name => "by_author", :unique => true
  add_index "publication_titles_authors", ["publication_title_id"], :name => "index_publication_titles_authors_on_publication_title_id"

  create_table "redirects", :force => true do |t|
    t.string   "old_url",    :null => false
    t.string   "new_url",    :null => false
    t.string   "http_code",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redirects", ["old_url"], :name => "index_redirects_on_old_url", :unique => true

  create_table "reference_figures", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "avatar_file_name"
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type"
    t.datetime "avatar_updated_at"
    t.string   "exploded_view_file_name"
    t.integer  "exploded_view_file_size"
    t.string   "exploded_view_content_type"
    t.datetime "exploded_view_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "units", :force => true do |t|
    t.integer  "product_line_id",     :null => false
    t.integer  "reference_figure_id"
    t.string   "name",                :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units", ["product_line_id"], :name => "index_units_on_product_line_id"
  add_index "units", ["reference_figure_id"], :name => "index_units_on_reference_figure_id"

  create_table "units_makes", :force => true do |t|
    t.integer  "unit_id",                    :null => false
    t.integer  "make_id",                    :null => false
    t.text     "description"
    t.integer  "sort_order",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units_makes", ["make_id"], :name => "index_units_makes_on_make_id"
  add_index "units_makes", ["unit_id", "make_id"], :name => "by_unit", :unique => true
  add_index "units_makes", ["unit_id"], :name => "index_units_makes_on_unit_id"

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
