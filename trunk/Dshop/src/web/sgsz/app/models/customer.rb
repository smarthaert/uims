class Customer < ActiveRecord::Base
  attr_accessible :address, :cdate, :cid, :cname, :email, :loginname, :qq, :remark, :sex, :shopname, :state, :tel
end
