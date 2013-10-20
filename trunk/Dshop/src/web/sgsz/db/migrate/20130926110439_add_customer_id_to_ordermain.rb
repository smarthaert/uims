class AddCustomerIdToOrdermain < ActiveRecord::Migration
  def change
    add_column :ordermains, :customer_id, :string
  end
end
