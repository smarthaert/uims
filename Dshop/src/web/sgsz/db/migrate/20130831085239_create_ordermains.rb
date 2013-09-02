class CreateOrdermains < ActiveRecord::Migration
  def change
    create_table :ordermains do |t|
      t.string :oid
      t.string :custid
      t.string :custstate
      t.string :custname
      t.string :shopname
      t.string :custtel
      t.string :custaddr
      t.decimal :yingshou, :precision => 10, :scale => 2
      t.decimal :shishou, :precision => 10, :scale => 2
      t.string :sid
      t.string :sname
      t.string :stel
      t.string :saddress
      t.string :payment
      t.integer :status
      t.string :uid
      t.string :uname
      t.string :preid
      t.string :nextid
      t.string :type
      t.date :cdate
      t.date :canal
      t.text :remark

      t.timestamps
    end
    add_index :ordermains, :oid, :unique => true
  end
end
