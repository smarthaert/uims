class CreateAfterselldetails < ActiveRecord::Migration
  def change
    create_table :afterselldetails do |t|
      t.string :stid
      t.string :stname
      t.string :tid
      t.string :pid
      t.string :barcode
      t.string :goodsname
      t.string :size
      t.string :color
      t.decimal :volume, :precision => 10, :scale => 2
      t.string :unit
      t.decimal :inprice, :precision => 10, :scale => 2
      t.decimal :pfprice, :precision => 10, :scale => 2
      t.decimal :hprice, :precision => 10, :scale => 2
      t.decimal :outprice, :precision => 10, :scale => 2
      t.integer :amount
      t.integer :ramount
      t.integer :bundle
      t.integer :rbundle
      t.integer :discount
      t.string :additional
      t.string :type
      t.decimal :subtotal, :precision => 10, :scale => 2
      t.integer :status
      t.date :cdate
      t.text :remark

      t.timestamps
    end
    add_index :afterselldetails, :tid, :unique => true
  end
end
