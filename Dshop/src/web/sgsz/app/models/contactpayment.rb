class Contactpayment < ActiveRecord::Base
  attr_accessible :cdate, :custid, :custname, :inmoney, :method, :outmoney, :proof, :remark, :status, :stid, :stname, :strike, :ticketid
end
