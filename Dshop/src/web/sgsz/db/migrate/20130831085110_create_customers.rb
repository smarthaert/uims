class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :cid
      t.string :loginname
      t.string :cname
      t.string :shopname
      t.string :sex
      t.string :address
      t.string :email
      t.string :qq
      t.string :tel
      t.string :state
      t.date :cdate
      t.text :remark

      t.timestamps
    end
    add_index :customers, :cid, :unique => true
    add_index :customers, :email, :unique => true
    add_index :customers, :qq, :unique => true
    add_index :customers, :tel, :unique => true
  end
end
