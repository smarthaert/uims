class CreateSelllogmains < ActiveRecord::Migration
  def change
    create_table :selllogmains do |t|
      t.string :stid
      t.string :stname
      t.string :slid
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
      t.integer :aamount
      t.decimal :avolume, :precision => 10, :scale => 2
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
      t.string :dtype
      t.date :cdate
      t.date :pdate
      t.text :remark

      t.timestamps
    end
    add_index :selllogmains, :slid, :unique => true
  end
end
