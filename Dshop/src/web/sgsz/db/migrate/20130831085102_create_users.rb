class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :loginname
      t.string :uname
      t.string :stid
      t.string :stname
      t.string :sex
      t.integer :age
      t.string :userpass
      t.text :address
      t.string :tel
      t.decimal :salari, :precision => 10, :scale => 2
      t.string :position
      t.date :cdate
      t.text :remark

      t.timestamps
    end
    add_index :users, :uid, :unique => true
    add_index :users, :tel, :unique => true
  end
end
