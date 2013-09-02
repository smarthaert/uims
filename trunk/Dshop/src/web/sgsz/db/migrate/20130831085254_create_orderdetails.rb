class CreateOrderdetails < ActiveRecord::Migration
  def change
    create_table :orderdetails do |t|
      t.string :oid
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
      t.decimal :subtotal, :precision => 10, :scale => 2
      t.integer :status
      t.date :cdate
      t.text :remark

      t.timestamps
    end
  end
end
