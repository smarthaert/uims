class CreateAftersellmains < ActiveRecord::Migration
  def change
    create_table :aftersellmains do |t|
      t.string :stid
      t.string :stname
      t.string :tid
      t.string :custid
      t.string :custstate
      t.string :custname
      t.string :shopname
      t.string :custtel
      t.string :custaddr
      t.decimal :yingshou, :precision => 10, :scale => 2
      t.decimal :shishou, :precision => 10, :scale => 2
      t.decimal :shoukuan, :precision => 10, :scale => 2
      t.decimal :zhaoling, :precision => 10, :scale => 2
      t.decimal :yingtui, :precision => 10, :scale => 2
      t.decimal :shitui, :precision => 10, :scale => 2
      t.decimal :fukuan, :precision => 10, :scale => 2
      t.decimal :zhaohui, :precision => 10, :scale => 2
      t.string :sid
      t.string :sname
      t.string :stel
      t.string :saddress
      t.string :payment
      t.string :tpayment
      t.integer :status
      t.string :uid
      t.string :tuid
      t.string :uname
      t.string :tuname
      t.string :dtype
      t.string :preid
      t.string :nextid
      t.date :cdate
      t.date :pdate
      t.text :tremark
      t.text :remark

      t.timestamps
    end
    add_index :aftersellmains, :tid, :unique => true
  end
end
