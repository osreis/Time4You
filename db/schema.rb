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

ActiveRecord::Schema.define(:version => 20130429170657) do

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

  create_table "cashiers", :force => true do |t|
    t.decimal  "initial_amount"
    t.date     "opened"
    t.date     "closed"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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

  create_table "ordercells", :force => true do |t|
    t.integer  "quantity"
    t.integer  "order_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.decimal  "product_sold_price"
  end

  add_index "ordercells", ["order_id"], :name => "index_ordercells_on_order_id"

  create_table "ordercells_products", :id => false, :force => true do |t|
    t.integer "ordercells_id"
    t.integer "products_id"
    t.integer "ordercell_id"
    t.integer "product_id"
  end

  create_table "orders", :force => true do |t|
    t.date     "created"
    t.string   "paymentType"
    t.decimal  "discount"
    t.string   "status"
    t.date     "updated"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.decimal  "amount"
    t.decimal  "consumerAmount"
    t.decimal  "costPrice"
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "orders_payment_types", :id => false, :force => true do |t|
    t.integer "orders_id"
    t.integer "payment_types_id"
    t.integer "order_id"
    t.integer "payment_type_id"
  end

  create_table "payment_types", :force => true do |t|
    t.decimal  "discount"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  add_index "payment_types", ["order_id"], :name => "index_payment_types_on_order_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "barcode"
    t.string   "regular_purchase_price"
    t.string   "regular_sale_price"
    t.integer  "in_stock_quantity"
    t.integer  "brand_id"
    t.integer  "order_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "ordercell_id"
  end

  add_index "products", ["order_id"], :name => "index_products_on_order_id"
  add_index "products", ["ordercell_id"], :name => "index_products_on_ordercell_id"

  create_table "salecells", :force => true do |t|
    t.integer  "quantity"
    t.integer  "ordercell_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "salecells", ["ordercell_id"], :name => "index_salecells_on_ordercell_id"

  create_table "salecells_special_products", :id => false, :force => true do |t|
    t.integer "salecells_id"
    t.integer "special_products_id"
    t.integer "salecell_id"
    t.integer "special_product_id"
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
    t.integer  "salecell_id"
  end

  add_index "special_products", ["product_id"], :name => "index_special_products_on_product_id"
  add_index "special_products", ["salecell_id"], :name => "index_special_products_on_salecell_id"

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
    t.decimal  "commission"
  end

  add_index "users", ["group_id"], :name => "index_users_on_group_id"

end
