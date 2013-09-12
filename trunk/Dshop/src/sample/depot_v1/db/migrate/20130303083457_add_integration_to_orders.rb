class AddIntegrationToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :integration, :string
  end
end
