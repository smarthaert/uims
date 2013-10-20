#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Cart < ActiveRecord::Base
  attr_accessible :teller
  has_many :orderdetails, dependent: :destroy

  def add_product(stock_id,custid)
    current_item = orderdetails.find_by_stock_id(stock_id)
    if current_item
      current_item.amount += 1
    else
      current_item = orderdetails.build(stock_id: stock_id)
      current_item.amount = 1
      stock = Stock.find_by_id(stock_id)
      mp = Memberprice.where("pid = ? and custid = ? and current_timestamp() between startdate and enddate", stock.pid, custid).first
      if mp
        current_item.outprice = mp.hprice
      else
        current_item.outprice = current_item.stock.pfprice
      end
    end
    current_item
  end

  def total_price
    orderdetails.to_a.sum { |item| item.total_price }
  end
end
