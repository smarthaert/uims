class CreateSelllogdetails < ActiveRecord::Migration
  def change
    create_table :selllogdetails do |t|
      t.string :stid
      t.string :stname
      t.string :slid
      t.string :store
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
      t.integer :camount
      t.integer :bundle
      t.integer :cbundle
      t.integer :discount
      t.string :additional
      t.string :type
      t.decimal :subtotal, :precision => 10, :scale => 2
      t.integer :status
      t.date :cdate
      t.date :pdate
      t.text :remark

      t.timestamps
    end
  end
end
