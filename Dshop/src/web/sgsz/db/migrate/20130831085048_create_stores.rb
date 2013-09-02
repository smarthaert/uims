class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :stid
      t.string :stname
      t.string :staddress
      t.string :starea
      t.string :sttel
      t.date :cdate
      t.text :remark

      t.timestamps
    end
    add_index :stores, :stid, :unique => true
  end
end
