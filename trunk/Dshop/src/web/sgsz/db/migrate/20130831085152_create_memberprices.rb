class CreateMemberprices < ActiveRecord::Migration
  def change
    create_table :memberprices do |t|
      t.string :pid
      t.string :barcode
      t.string :goodsname
      t.string :size
      t.string :color
      t.decimal :volume, :precision => 10, :scale => 2
      t.string :unit
      t.string :custid
      t.string :custname
      t.string :custtel
      t.date :startdate
      t.date :enddate
      t.decimal :hprice, :precision => 10, :scale => 2
      t.date :cdate
      t.text :remark

      t.timestamps
    end
  end
end
