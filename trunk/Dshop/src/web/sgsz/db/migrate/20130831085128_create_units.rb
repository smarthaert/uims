class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :uname
      t.date :cdate
      t.text :remark

      t.timestamps
    end
    add_index :units, :uname, :unique => true
  end
end
