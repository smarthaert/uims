class CreateFeeders < ActiveRecord::Migration
  def change
    create_table :feeders do |t|
      t.string :fid
      t.string :feedername
      t.string :brand
      t.string :linkman
      t.string :address
      t.string :email
      t.string :qq
      t.string :zipcode
      t.string :tel
      t.string :fax
      t.date :cdate
      t.text :remark

      t.timestamps
    end
    add_index :feeders, :fid, :unique => true
    add_index :feeders, :feedername, :unique => true
    add_index :feeders, :email, :unique => true
    add_index :feeders, :qq, :unique => true
    add_index :feeders, :tel, :unique => true
    add_index :feeders, :fax, :unique => true
  end
end
