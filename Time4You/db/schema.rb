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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120902161000) do

  create_table "backups", :force => true do |t|
    t.date     "date"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "representative_name"
    t.string   "representative_email"
    t.string   "representative_phone"
    t.text     "extra_info"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "catalogs", :force => true do |t|
    t.string   "name"
    t.date     "endDate"
    t.date     "beginDate"
    t.integer  "brand_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "catalogs", ["brand_id"], :name => "index_catalogs_on_brand_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "internal_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sales", :force => true do |t|
    t.decimal  "salePrice"
    t.integer  "product_id"
    t.integer  "catalog_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sales", ["catalog_id"], :name => "index_sales_on_catalog_id"
  add_index "sales", ["product_id"], :name => "index_sales_on_product_id"

  create_table "special_products", :force => true do |t|
    t.integer  "total"
    t.integer  "available"
    t.decimal  "specialPrice"
    t.integer  "product_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "special_products", ["product_id"], :name => "index_special_products_on_product_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.string   "address"
    t.string   "phone"
    t.date     "birthDate"
    t.string   "cpf"
    t.string   "login"
    t.string   "mobile"
    t.string   "gender"
    t.string   "city"
    t.string   "state"
    t.string   "cep"
    t.integer  "group_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "auth_token"
  end

  add_index "users", ["group_id"], :name => "index_users_on_group_id"

end
