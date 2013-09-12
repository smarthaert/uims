class AddCellPhoneToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cell_phone, :string
  end
end
