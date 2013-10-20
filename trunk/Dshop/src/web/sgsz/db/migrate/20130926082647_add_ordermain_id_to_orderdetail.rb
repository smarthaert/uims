class AddOrdermainIdToOrderdetail < ActiveRecord::Migration
  def change
    add_column :orderdetails, :ordermain_id, :string
  end
end
