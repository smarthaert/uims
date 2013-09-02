class Shipper < ActiveRecord::Base
  attr_accessible :address, :cdate, :custid, :custname, :custtel, :remark, :sid, :sname, :tel
end
