class CreateBuylogs < ActiveRecord::Migration
  def change
    create_table :buylogs do |t|
      t.string :uid
      t.string :uname
      t.string :utel
      t.string :cpbh
      t.string :cpmc
      t.string :ys
      t.string :sl
      t.string :js
      t.decimal :dj, :precision => 10, :scale => 2
      t.decimal :yfbz, :precision => 10, :scale => 2
      t.decimal :xj, :precision => 10, :scale => 2
      t.decimal :tj, :precision => 10, :scale => 2
      t.string :bz
      t.date :cdate
      t.text :remark

      t.timestamps
    end
  end
end
