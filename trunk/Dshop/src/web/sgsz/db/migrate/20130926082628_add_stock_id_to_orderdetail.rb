class AddStockIdToOrderdetail < ActiveRecord::Migration
  def change
    add_column :orderdetails, :stock_id, :string
  end
end
