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

ActiveRecord::Schema.define(:version => 20100728222252) do

  create_table "assets", :force => true do |t|
    t.string   "asset_file_name",    :null => false
    t.integer  "asset_file_size"
    t.string   "asset_content_type"
    t.datetime "asset_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["asset_content_type"], :name => "index_assets_on_asset_content_type"

  create_table "catalog_formats", :force => true do |t|
    t.string   "title",        :limit => 100, :null => false
    t.string   "url_friendly", :limit => 100, :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "catalog_formats", ["url_friendly"], :name => "index_catalog_formats_on_url_friendly", :unique => true

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

  create_table "part_asset_types", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "url_friendly", :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key_name"
  end

  add_index "part_asset_types", ["key_name"], :name => "index_part_asset_types_on_key_name", :unique => true
  add_index "part_asset_types", ["name"], :name => "index_part_asset_types_on_name"
  add_index "part_asset_types", ["url_friendly"], :name => "index_part_asset_types_on_url_friendly", :unique => true

  create_table "part_assets", :force => true do |t|
    t.integer  "part_id",            :null => false
    t.integer  "part_asset_type_id", :null => false
    t.integer  "asset_id",           :null => false
    t.string   "name"
    t.text     "description"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "part_assets", ["asset_id"], :name => "index_part_assets_on_asset_id"
  add_index "part_assets", ["part_asset_type_id"], :name => "index_part_assets_on_part_asset_type_id"
  add_index "part_assets", ["part_id", "part_asset_type_id", "asset_id"], :name => "by_type", :unique => true
  add_index "part_assets", ["part_id"], :name => "index_part_assets_on_part_id"

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

  create_table "part_types", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "url_friendly", :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "part_types", ["name"], :name => "index_part_types_on_name"
  add_index "part_types", ["url_friendly"], :name => "index_part_types_on_url_friendly", :unique => true

  create_table "parts", :force => true do |t|
    t.integer  "part_type_id",                       :null => false
    t.string   "part_number"
    t.string   "oem_part_number"
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.float    "weight"
    t.string   "ref_code"
    t.integer  "ref_code_sort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "item"
    t.text     "notes"
    t.integer  "product_line_id",                    :null => false
    t.boolean  "is_featured",     :default => false
    t.boolean  "is_new_item",     :default => false
  end

  add_index "parts", ["is_featured"], :name => "index_parts_on_is_featured"
  add_index "parts", ["oem_part_number"], :name => "index_parts_on_oem_part_number"
  add_index "parts", ["part_number"], :name => "index_parts_on_part_number"
  add_index "parts", ["part_type_id"], :name => "index_parts_on_part_type_id"

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

  create_table "product_line_parts", :force => true do |t|
    t.integer  "product_line_id",                    :null => false
    t.integer  "part_id",                            :null => false
    t.text     "summary"
    t.text     "description"
    t.integer  "sort_order"
    t.boolean  "is_featured",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_line_parts", ["is_featured"], :name => "index_product_line_parts_on_is_featured"
  add_index "product_line_parts", ["part_id"], :name => "index_product_line_parts_on_part_id"
  add_index "product_line_parts", ["product_line_id", "part_id"], :name => "by_part", :unique => true
  add_index "product_line_parts", ["product_line_id"], :name => "index_product_line_parts_on_product_line_id"

  create_table "product_lines", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "url_friendly",                   :null => false
    t.boolean  "is_active",    :default => true
    t.integer  "sort_order",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
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
    t.integer  "sort_order"
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

  create_table "publication_keyword_types", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publication_keywords", :force => true do |t|
    t.integer  "publication_keyword_type_id", :null => false
    t.string   "title",                       :null => false
    t.string   "url_friendly",                :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_keywords", ["publication_keyword_type_id", "url_friendly"], :name => "by_keyword_type", :unique => true
  add_index "publication_keywords", ["publication_keyword_type_id"], :name => "index_publication_keywords_on_publication_keyword_type_id"
  add_index "publication_keywords", ["url_friendly"], :name => "index_publication_keywords_on_url_friendly"

  create_table "publication_subjects", :force => true do |t|
    t.string   "title",                       :null => false
    t.string   "url_friendly",                :null => false
    t.text     "description"
    t.integer  "sort_order",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_subjects", ["url_friendly"], :name => "index_publication_subjects_on_url_friendly", :unique => true

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

  create_table "publication_titles_keywords", :force => true do |t|
    t.integer  "publication_title_id",   :null => false
    t.integer  "publication_keyword_id", :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles_keywords", ["publication_keyword_id"], :name => "index_publication_titles_keywords_on_publication_keyword_id"
  add_index "publication_titles_keywords", ["publication_title_id", "publication_keyword_id"], :name => "by_keyword", :unique => true
  add_index "publication_titles_keywords", ["publication_title_id"], :name => "index_publication_titles_keywords_on_publication_title_id"

  create_table "publication_titles_makes", :force => true do |t|
    t.integer  "publication_title_id", :null => false
    t.integer  "make_id",              :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles_makes", ["make_id"], :name => "index_publication_titles_makes_on_make_id"
  add_index "publication_titles_makes", ["publication_title_id", "make_id"], :name => "by_make", :unique => true
  add_index "publication_titles_makes", ["publication_title_id"], :name => "index_publication_titles_makes_on_publication_title_id"

  create_table "publication_titles_product_lines", :force => true do |t|
    t.integer  "publication_title_id", :null => false
    t.integer  "product_line_id",      :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles_product_lines", ["product_line_id"], :name => "index_publication_titles_product_lines_on_product_line_id"
  add_index "publication_titles_product_lines", ["publication_title_id", "product_line_id"], :name => "by_product_line", :unique => true
  add_index "publication_titles_product_lines", ["publication_title_id"], :name => "index_publication_titles_product_lines_on_publication_title_id"

  create_table "publication_titles_subjects", :force => true do |t|
    t.integer  "publication_title_id",   :null => false
    t.integer  "publication_subject_id", :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles_subjects", ["publication_subject_id"], :name => "index_publication_titles_subjects_on_publication_subject_id"
  add_index "publication_titles_subjects", ["publication_title_id", "publication_subject_id"], :name => "by_subject", :unique => true
  add_index "publication_titles_subjects", ["publication_title_id"], :name => "index_publication_titles_subjects_on_publication_title_id"

  create_table "publication_titles_types", :force => true do |t|
    t.integer  "publication_title_id", :null => false
    t.integer  "publication_type_id",  :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles_types", ["publication_title_id", "publication_type_id"], :name => "by_type", :unique => true
  add_index "publication_titles_types", ["publication_title_id"], :name => "index_publication_titles_types_on_publication_title_id"
  add_index "publication_titles_types", ["publication_type_id"], :name => "index_publication_titles_types_on_publication_type_id"

  create_table "publication_titles_units", :force => true do |t|
    t.integer  "publication_title_id", :null => false
    t.integer  "unit_id",              :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles_units", ["publication_title_id", "unit_id"], :name => "by_unit", :unique => true
  add_index "publication_titles_units", ["publication_title_id"], :name => "index_publication_titles_units_on_publication_title_id"
  add_index "publication_titles_units", ["unit_id"], :name => "index_publication_titles_units_on_unit_id"

  create_table "publication_titles_units_makes", :force => true do |t|
    t.integer  "publication_title_id", :null => false
    t.integer  "units_make_id",        :null => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_titles_units_makes", ["publication_title_id", "units_make_id"], :name => "by_unit_and_make", :unique => true
  add_index "publication_titles_units_makes", ["publication_title_id"], :name => "index_publication_titles_units_makes_on_publication_title_id"
  add_index "publication_titles_units_makes", ["units_make_id"], :name => "index_publication_titles_units_makes_on_units_make_id"

  create_table "publication_types", :force => true do |t|
    t.string   "title",                       :null => false
    t.string   "url_friendly",                :null => false
    t.text     "description"
    t.integer  "sort_order",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publication_types", ["url_friendly"], :name => "index_publication_types_on_url_friendly", :unique => true

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

  create_table "solenoid_programs", :force => true do |t|
    t.string   "name",              :null => false
    t.string   "company",           :null => false
    t.string   "address",           :null => false
    t.string   "city",              :null => false
    t.string   "state",             :null => false
    t.string   "postal_code",       :null => false
    t.string   "phone",             :null => false
    t.string   "email"
    t.string   "fax"
    t.integer  "number_of_cores",   :null => false
    t.string   "core_applications"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solenoid_programs", ["email"], :name => "index_solenoid_programs_on_email"
  add_index "solenoid_programs", ["name"], :name => "index_solenoid_programs_on_name"

  create_table "states", :force => true do |t|
    t.string   "name",         :limit => 100, :null => false
    t.string   "url_friendly", :limit => 100, :null => false
    t.string   "code",         :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["code"], :name => "index_states_on_code"
  add_index "states", ["url_friendly"], :name => "index_states_on_url_friendly", :unique => true

  create_table "unit_components", :force => true do |t|
    t.integer  "unit_id",                                 :null => false
    t.integer  "part_id",                                 :null => false
    t.integer  "display_order",            :default => 1
    t.integer  "indent",                   :default => 0
    t.string   "code_on_reference_figure"
    t.text     "description"
    t.text     "notes"
    t.string   "steel_driveshaft_tube_od"
    t.string   "torque_fuse_options"
    t.string   "pts_series"
    t.string   "driveline_series"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unit_components", ["part_id"], :name => "index_unit_components_on_part_id"
  add_index "unit_components", ["unit_id", "part_id"], :name => "by_part"
  add_index "unit_components", ["unit_id"], :name => "index_unit_components_on_unit_id"

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
