#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Ordermain < ActiveRecord::Base
  PAYMENT_TYPES = [ I18n.t("cash"), I18n.t("credit_card"), I18n.t("integration") ]
  attr_accessible :custaddr, :custname, :payment, :custtel, :uname, :remark
  has_many :orderdetails, dependent: :destroy
  belongs_to :customer
  # ...
 # validates :custname, :custaddr, presence: true
 # validates :payment, inclusion: PAYMENT_TYPES
  def add_orderdetails_from_cart(cart)
    cart.orderdetails.each do |item|
      item.cart_id = nil
      orderdetails << item
    end
  end
end
