class Stock < ActiveRecord::Base
  attr_accessible :amount, :barcode, :baseline, :bundle, :color, :discount, :goodsname, :inprice, :pfprice, :pid, :remark, :size, :stid, :stname, :unit, :volume
end
