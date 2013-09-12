class AddDiscountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount, :decimal
  end
end
