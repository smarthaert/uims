class AddTellerToCart < ActiveRecord::Migration
  def change
    add_column :carts, :teller, :string
  end
end
