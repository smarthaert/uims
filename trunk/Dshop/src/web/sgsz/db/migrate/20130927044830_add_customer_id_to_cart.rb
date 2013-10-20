class AddCustomerIdToCart < ActiveRecord::Migration
  def change
    add_column :carts, :customer_id, :string
  end
end
