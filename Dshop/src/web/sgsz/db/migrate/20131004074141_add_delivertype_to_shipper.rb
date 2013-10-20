class AddDelivertypeToShipper < ActiveRecord::Migration
  def change
    add_column :shippers, :delivertype, :string
  end
end
