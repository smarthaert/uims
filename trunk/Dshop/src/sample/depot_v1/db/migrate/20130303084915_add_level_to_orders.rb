class AddLevelToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :level, :string
  end
end
