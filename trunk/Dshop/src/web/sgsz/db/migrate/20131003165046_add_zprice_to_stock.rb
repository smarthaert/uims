class AddZpriceToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :zprice, :decimal, :precision => 10, :scale => 2
  end
end
