class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :stid
      t.string :stname
      t.string :pid
      t.string :barcode
      t.string :goodsname
      t.string :size
      t.string :color
      t.integer :amount
      t.decimal :volume, :precision => 10, :scale => 2
      t.string :unit
      t.decimal :inprice, :precision => 10, :scale => 2
      t.decimal :pfprice, :precision => 10, :scale => 2
      t.integer :bundle
      t.integer :discount
      t.integer :baseline
      t.text :remark

      t.timestamps
    end
    add_index :stocks, :pid, :unique => true
    add_index :stocks, :barcode, :unique => true
  end
end
