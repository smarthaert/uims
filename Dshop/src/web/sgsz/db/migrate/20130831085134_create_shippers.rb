class CreateShippers < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.string :sid
      t.string :sname
      t.string :tel
      t.string :address
      t.string :custid
      t.string :custname
      t.string :custtel
      t.date :cdate
      t.text :remark

      t.timestamps
    end
  end
end
