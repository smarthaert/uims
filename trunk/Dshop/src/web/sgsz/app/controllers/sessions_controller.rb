#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    #customer = Customer.find_by_loginname(params[:loginname])
    #if customer and customer.authenticate(params[:password])
    if customer = Customer.authenticate(params[:loginname], params[:password]) 
      session[:customer_id] = customer.id
      session[:cid] = customer.cid
      session[:cname] = customer.cname
      redirect_to admin_url
    else
      redirect_to login_url, alert: t('.invalid_user_password_combination')
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to store_url, notice: t('.logged_out')
  end
end
