class Orderdetail < ActiveRecord::Base
  attr_accessible :additional, :amount, :barcode, :bundle, :cdate, :color, :discount, :goodsname, :hprice, :inprice, :oid, :outprice, :pfprice, :pid, :ramount, :rbundle, :remark, :size, :status, :subtotal, :unit, :volume
end
