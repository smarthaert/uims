class CreateContactpayments < ActiveRecord::Migration
  def change
    create_table :contactpayments do |t|
      t.string :stid
      t.string :stname
      t.string :custid
      t.string :custname
      t.decimal :outmoney, :precision => 10, :scale => 2
      t.decimal :inmoney, :precision => 10, :scale => 2
      t.decimal :strike, :precision => 10, :scale => 2
      t.string :method
      t.string :proof
      t.string :ticketid
      t.date :cdate
      t.string :status
      t.text :remark

      t.timestamps
    end
    add_index :contactpayments, :ticketid, :unique => true
  end
end
