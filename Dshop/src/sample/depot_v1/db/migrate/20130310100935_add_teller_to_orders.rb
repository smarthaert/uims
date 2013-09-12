class AddTellerToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :teller, :string
  end
end
