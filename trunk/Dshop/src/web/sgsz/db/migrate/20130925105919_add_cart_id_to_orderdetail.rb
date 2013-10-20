class AddCartIdToOrderdetail < ActiveRecord::Migration
  def change
    add_column :orderdetails, :cart_id, :string
  end
end
