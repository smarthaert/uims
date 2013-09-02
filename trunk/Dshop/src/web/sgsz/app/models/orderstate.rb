class Orderstate < ActiveRecord::Base
  attr_accessible :amount, :payment, :type, :value
end
