#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class OrderNotifier < ActionMailer::Base
  default from: 'robot <vip_test@163.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(ordermain)
    @ordermain = ordermain

#    mail to: "15955138772@139.com", subject: @ordermain.oid 
     mail to: "12442835@qq.com", subject: 'Order'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(ordermain)
    @ordermain = ordermain
    customer = Customer.find_by_tel(ordermain.custtel)

    mail to: customer.email, subject: 'Pragmatic Store Order Shipped'
  end
end
