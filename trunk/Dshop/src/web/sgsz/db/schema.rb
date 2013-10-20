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

ActiveRecord::Schema.define(:version => 20131004074141) do

  create_table "afterselldetails", :force => true do |t|
    t.string   "stid"
    t.string   "stname"
    t.string   "tid"
    t.string   "pid"
    t.string   "barcode"
    t.string   "goodsname"
    t.string   "size"
    t.string   "color"
    t.decimal  "volume",     :precision => 10, :scale => 2
    t.string   "unit"
    t.decimal  "inprice",    :precision => 10, :scale => 2
    t.decimal  "pfprice",    :precision => 10, :scale => 2
    t.decimal  "hprice",     :precision => 10, :scale => 2
    t.decimal  "outprice",   :precision => 10, :scale => 2
    t.integer  "amount"
    t.integer  "ramount"
    t.integer  "bundle"
    t.integer  "rbundle"
    t.integer  "discount"
    t.string   "additional"
    t.string   "dtype"
    t.decimal  "subtotal",   :precision => 10, :scale => 2
    t.integer  "status"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "afterselldetails", ["tid", "pid", "additional", "dtype"], :name => "tid_pid_type_additional", :unique => true

  create_table "aftersellmains", :force => true do |t|
    t.string   "stid"
    t.string   "stname"
    t.string   "tid"
    t.string   "custid"
    t.string   "custstate"
    t.string   "custname"
    t.string   "shopname"
    t.string   "custtel"
    t.string   "custaddr"
    t.decimal  "yingshou",   :precision => 10, :scale => 2
    t.decimal  "shishou",    :precision => 10, :scale => 2
    t.decimal  "shoukuan",   :precision => 10, :scale => 2
    t.decimal  "zhaoling",   :precision => 10, :scale => 2
    t.decimal  "yingtui",    :precision => 10, :scale => 2
    t.decimal  "shitui",     :precision => 10, :scale => 2
    t.decimal  "fukuan",     :precision => 10, :scale => 2
    t.decimal  "zhaohui",    :precision => 10, :scale => 2
    t.string   "sid"
    t.string   "sname"
    t.string   "stel"
    t.string   "saddress"
    t.string   "payment"
    t.string   "tpayment"
    t.integer  "status"
    t.string   "uid"
    t.string   "tuid"
    t.string   "uname"
    t.string   "tuname"
    t.string   "dtype"
    t.string   "preid"
    t.string   "nextid"
    t.date     "cdate"
    t.date     "pdate"
    t.text     "tremark"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "aftersellmains", ["tid"], :name => "index_aftersellmains_on_tid", :unique => true

  create_table "buylogs", :force => true do |t|
    t.string   "uid"
    t.string   "uname"
    t.string   "utel"
    t.string   "cpbh"
    t.string   "cpmc"
    t.string   "ys"
    t.string   "sl"
    t.string   "js"
    t.decimal  "dj",         :precision => 10, :scale => 2
    t.decimal  "yfbz",       :precision => 10, :scale => 2
    t.decimal  "xj",         :precision => 10, :scale => 2
    t.decimal  "tj",         :precision => 10, :scale => 2
    t.string   "bz"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "teller"
    t.string   "customer_id"
  end

  create_table "cidprofit", :id => false, :force => true do |t|
    t.string  "custtel"
    t.decimal "profit",  :precision => 32, :scale => 2
  end

  create_table "contactpayments", :force => true do |t|
    t.string   "stid"
    t.string   "stname"
    t.string   "custid"
    t.string   "custname"
    t.decimal  "outmoney",   :precision => 10, :scale => 2
    t.decimal  "inmoney",    :precision => 10, :scale => 2
    t.decimal  "strike",     :precision => 10, :scale => 2
    t.string   "method"
    t.string   "proof"
    t.string   "ticketid"
    t.date     "cdate"
    t.string   "status"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "contactpayments", ["ticketid"], :name => "index_contactpayments_on_ticketid", :unique => true

  create_table "customers", :force => true do |t|
    t.string   "cid"
    t.string   "loginname"
    t.string   "cname"
    t.string   "shopname"
    t.string   "sex"
    t.string   "address"
    t.string   "email"
    t.string   "qq"
    t.string   "tel"
    t.string   "state"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "hashed_password"
    t.string   "salt"
  end

  add_index "customers", ["cid"], :name => "index_customers_on_cid", :unique => true
  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true
  add_index "customers", ["qq"], :name => "index_customers_on_qq", :unique => true
  add_index "customers", ["tel"], :name => "index_customers_on_tel", :unique => true

  create_table "delivertypes", :id => false, :force => true do |t|
    t.string  "additional"
    t.decimal "amount",     :precision => 32, :scale => 0
  end

  create_table "feeders", :force => true do |t|
    t.string   "fid"
    t.string   "feedername"
    t.string   "brand"
    t.string   "linkman"
    t.string   "address"
    t.string   "email"
    t.string   "qq"
    t.string   "zipcode"
    t.string   "tel"
    t.string   "fax"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feeders", ["email"], :name => "index_feeders_on_email", :unique => true
  add_index "feeders", ["fax"], :name => "index_feeders_on_fax", :unique => true
  add_index "feeders", ["feedername"], :name => "index_feeders_on_feedername", :unique => true
  add_index "feeders", ["fid"], :name => "index_feeders_on_fid", :unique => true
  add_index "feeders", ["qq"], :name => "index_feeders_on_qq", :unique => true
  add_index "feeders", ["tel"], :name => "index_feeders_on_tel", :unique => true

  create_table "mauths", :force => true do |t|
    t.string   "uid"
    t.string   "rid"
    t.string   "mid"
    t.string   "cdkey"
    t.string   "result"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "mauths", ["cdkey"], :name => "index_mauths_on_cdkey", :unique => true
  add_index "mauths", ["mid"], :name => "index_mauths_on_mid", :unique => true

  create_table "memberprices", :force => true do |t|
    t.string   "pid"
    t.string   "barcode"
    t.string   "goodsname"
    t.string   "size"
    t.string   "color"
    t.decimal  "volume",     :precision => 10, :scale => 2
    t.string   "unit"
    t.string   "custid"
    t.string   "custname"
    t.string   "custtel"
    t.date     "startdate"
    t.date     "enddate"
    t.decimal  "hprice",     :precision => 10, :scale => 2
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "orderdetails", :force => true do |t|
    t.string   "oid"
    t.string   "pid"
    t.string   "barcode"
    t.string   "goodsname"
    t.string   "size"
    t.string   "color"
    t.decimal  "volume",       :precision => 10, :scale => 2
    t.string   "unit"
    t.decimal  "inprice",      :precision => 10, :scale => 2
    t.decimal  "pfprice",      :precision => 10, :scale => 2
    t.decimal  "hprice",       :precision => 10, :scale => 2
    t.decimal  "outprice",     :precision => 10, :scale => 2
    t.integer  "amount"
    t.integer  "ramount"
    t.integer  "bundle"
    t.integer  "rbundle"
    t.integer  "discount"
    t.string   "additional"
    t.decimal  "subtotal",     :precision => 10, :scale => 2
    t.integer  "status"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "cart_id"
    t.string   "stock_id"
    t.string   "ordermain_id"
  end

  create_table "orderinshorts", :id => false, :force => true do |t|
    t.string  "custname"
    t.string  "custtel"
    t.string  "pid"
    t.integer "amount",      :limit => 8
    t.string  "oid"
    t.date    "cdate"
    t.integer "stockamount"
  end

  create_table "ordermains", :force => true do |t|
    t.string   "oid"
    t.string   "custid"
    t.string   "custstate"
    t.string   "custname"
    t.string   "shopname"
    t.string   "custtel"
    t.string   "custaddr"
    t.decimal  "yingshou",    :precision => 10, :scale => 2
    t.decimal  "shishou",     :precision => 10, :scale => 2
    t.string   "sid"
    t.string   "sname"
    t.string   "stel"
    t.string   "saddress"
    t.string   "payment"
    t.integer  "status"
    t.string   "uid"
    t.string   "uname"
    t.string   "preid"
    t.string   "nextid"
    t.string   "dtype"
    t.date     "cdate"
    t.string   "canal"
    t.text     "remark"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "customer_id"
  end

  add_index "ordermains", ["oid"], :name => "index_ordermains_on_oid", :unique => true

  create_table "orderstates", :id => false, :force => true do |t|
    t.string  "type"
    t.string  "payment"
    t.decimal "amount",  :precision => 23, :scale => 0
    t.decimal "value",   :precision => 32, :scale => 2
  end

  create_table "pidprofit", :id => false, :force => true do |t|
    t.string  "pid"
    t.decimal "amount", :precision => 32, :scale => 0
    t.decimal "profit", :precision => 32, :scale => 2
  end

  create_table "productionpreferences", :id => false, :force => true do |t|
    t.string  "custstate"
    t.string  "pid"
    t.string  "goodsname"
    t.string  "color"
    t.decimal "amount",    :precision => 32, :scale => 0
  end

  create_table "profitareas", :id => false, :force => true do |t|
    t.string  "custstate"
    t.decimal "profit",    :precision => 32, :scale => 2
  end

  create_table "profitcustomers", :id => false, :force => true do |t|
    t.string  "cname"
    t.string  "tel"
    t.decimal "profit", :precision => 32, :scale => 2
  end

  create_table "profitproductions", :id => false, :force => true do |t|
    t.string  "pid"
    t.string  "goodsname"
    t.string  "color"
    t.decimal "profit",    :precision => 32, :scale => 2
  end

  create_table "profitshippers", :id => false, :force => true do |t|
    t.string  "sname"
    t.string  "tel"
    t.decimal "amount", :precision => 32, :scale => 0
    t.decimal "volume", :precision => 32, :scale => 2
    t.decimal "profit", :precision => 32, :scale => 2
  end

  create_table "purchases", :force => true do |t|
    t.string   "cpbh"
    t.string   "cpmc"
    t.string   "ys"
    t.integer  "sl"
    t.integer  "js"
    t.decimal  "dj",         :precision => 10, :scale => 2
    t.decimal  "yfbz",       :precision => 10, :scale => 2
    t.decimal  "xj",         :precision => 10, :scale => 2
    t.decimal  "tj",         :precision => 10, :scale => 2
    t.string   "bz"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "sellcostcustomers", :id => false, :force => true do |t|
    t.string  "cname"
    t.string  "tel"
    t.string  "type"
    t.decimal "amount", :precision => 32, :scale => 0
  end

  create_table "sellcostgifts", :id => false, :force => true do |t|
    t.string  "additional"
    t.decimal "cost",       :precision => 32, :scale => 2
  end

  create_table "sellcostproductions", :id => false, :force => true do |t|
    t.string  "pid"
    t.string  "color"
    t.string  "type"
    t.decimal "amount", :precision => 32, :scale => 0
    t.string  "unit"
  end

  create_table "selllogdetails", :force => true do |t|
    t.string   "stid"
    t.string   "stname"
    t.string   "slid"
    t.string   "store"
    t.string   "pid"
    t.string   "barcode"
    t.string   "goodsname"
    t.string   "size"
    t.string   "color"
    t.decimal  "volume",     :precision => 10, :scale => 2
    t.string   "unit"
    t.decimal  "inprice",    :precision => 10, :scale => 2
    t.decimal  "pfprice",    :precision => 10, :scale => 2
    t.decimal  "hprice",     :precision => 10, :scale => 2
    t.decimal  "outprice",   :precision => 10, :scale => 2
    t.integer  "amount"
    t.integer  "camount"
    t.integer  "bundle"
    t.integer  "cbundle"
    t.integer  "discount"
    t.string   "additional"
    t.string   "dtype"
    t.decimal  "subtotal",   :precision => 10, :scale => 2
    t.integer  "status"
    t.date     "cdate"
    t.date     "pdate"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "selllogdetails", ["slid", "pid", "additional"], :name => "slid_pid_additional", :unique => true

  create_table "selllogmains", :force => true do |t|
    t.string   "stid"
    t.string   "stname"
    t.string   "slid"
    t.string   "custid"
    t.string   "custstate"
    t.string   "custname"
    t.string   "shopname"
    t.string   "custtel"
    t.string   "custaddr"
    t.decimal  "yingshou",   :precision => 10, :scale => 2
    t.decimal  "shishou",    :precision => 10, :scale => 2
    t.decimal  "shoukuan",   :precision => 10, :scale => 2
    t.decimal  "zhaoling",   :precision => 10, :scale => 2
    t.integer  "aamount"
    t.decimal  "avolume",    :precision => 10, :scale => 2
    t.string   "sid"
    t.string   "sname"
    t.string   "stel"
    t.string   "saddress"
    t.string   "payment"
    t.integer  "status"
    t.string   "uid"
    t.string   "uname"
    t.string   "preid"
    t.string   "nextid"
    t.string   "dtype"
    t.date     "cdate"
    t.date     "pdate"
    t.text     "remark"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "selllogmains", ["slid"], :name => "index_selllogmains_on_slid", :unique => true

  create_table "shippers", :force => true do |t|
    t.string   "sid"
    t.string   "sname"
    t.string   "tel"
    t.string   "address"
    t.string   "custid"
    t.string   "custname"
    t.string   "custtel"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "delivertype"
  end

  create_table "sidprofit", :id => false, :force => true do |t|
    t.string  "stel"
    t.decimal "profit", :precision => 32, :scale => 2
    t.decimal "amount", :precision => 32, :scale => 0
    t.decimal "volume", :precision => 32, :scale => 2
  end

  create_table "statementdays", :id => false, :force => true do |t|
    t.string  "date",     :limit => 10
    t.string  "method"
    t.decimal "outmoney",               :precision => 32, :scale => 2
    t.decimal "inmoney",                :precision => 32, :scale => 2
    t.decimal "strike",                 :precision => 32, :scale => 2
  end

  create_table "stocknews", :id => false, :force => true do |t|
    t.string  "pid"
    t.string  "goodsname"
    t.string  "color"
    t.integer "amount"
    t.string  "unit"
    t.decimal "volume",    :precision => 10, :scale => 2
  end

  create_table "stockrepairs", :id => false, :force => true do |t|
    t.string  "pid"
    t.string  "goodsname"
    t.string  "color"
    t.decimal "amount",    :precision => 32, :scale => 0
    t.string  "unit"
    t.decimal "volume",    :precision => 10, :scale => 2
  end

  create_table "stocks", :force => true do |t|
    t.string   "stid"
    t.string   "stname"
    t.string   "pid"
    t.string   "barcode"
    t.string   "goodsname"
    t.string   "size"
    t.string   "color"
    t.integer  "amount"
    t.decimal  "volume",               :precision => 10, :scale => 2
    t.string   "unit"
    t.decimal  "inprice",              :precision => 10, :scale => 2
    t.decimal  "pfprice",              :precision => 10, :scale => 2
    t.integer  "bundle"
    t.integer  "discount"
    t.integer  "baseline"
    t.text     "remark"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.decimal  "zprice",               :precision => 10, :scale => 2
  end

  add_index "stocks", ["barcode"], :name => "index_stocks_on_barcode", :unique => true
  add_index "stocks", ["pid"], :name => "index_stocks_on_pid", :unique => true

  create_table "stocktips", :id => false, :force => true do |t|
    t.string  "pid"
    t.string  "goodsname"
    t.string  "color"
    t.integer "amount"
    t.string  "unit"
    t.integer "baseline"
  end

  create_table "stores", :force => true do |t|
    t.string   "stid"
    t.string   "stname"
    t.string   "staddress"
    t.string   "starea"
    t.string   "sttel"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "stores", ["stid"], :name => "index_stores_on_stid", :unique => true

  create_table "units", :force => true do |t|
    t.string   "uname"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "units", ["uname"], :name => "index_units_on_uname", :unique => true

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "loginname"
    t.string   "uname"
    t.string   "stid"
    t.string   "stname"
    t.string   "sex"
    t.integer  "age"
    t.string   "userpass"
    t.text     "address"
    t.string   "tel"
    t.decimal  "salari",          :precision => 10, :scale => 2
    t.string   "position"
    t.date     "cdate"
    t.text     "remark"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "hashed_password"
    t.string   "salt"
  end

  add_index "users", ["tel"], :name => "index_users_on_tel", :unique => true
  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

end
