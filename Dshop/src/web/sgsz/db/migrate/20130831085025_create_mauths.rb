class CreateMauths < ActiveRecord::Migration
  def change
    create_table :mauths do |t|
      t.string :uid
      t.string :rid
      t.string :mid
      t.string :cdkey
      t.string :result
      t.date :cdate
      t.text :remark

      t.timestamps
    end
    add_index :mauths, :mid, :unique => true
    add_index :mauths, :cdkey, :unique => true
  end
end
