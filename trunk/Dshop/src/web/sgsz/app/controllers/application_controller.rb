#---

#---
class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  # ...
  before_filter :authorize
  protect_from_forgery

  private

    def current_cart 
      cart = Cart.find_by_id(session[:cart_id])
      if cart.nil?
        customer = Customer.find_by_id(session[:customer_id])
        cart = Cart.find_by_teller(customer.loginname)
        if cart.nil?
          cart = customer.build_cart
          session[:cart_id] = cart.id
          cart.teller = customer.loginname 
          cart.save
        end
      end
      cart
    end

    def current_ordermain 
      @cart = current_cart
      ordermain = Ordermain.find_by_id(session[:ordermain_id])
      if ordermain.nil?
        customer = Customer.find_by_id(session[:customer_id])
        ordermain = Ordermain.where("id = ?", @cart.orderdetails.first.ordermain_id).first
        if ordermain.nil?
          ordermain = Ordermain.new
          ordermain.customer_id = customer.id
          session[:ordermain_id] = ordermain.id
          ordermain.custid = customer.cid 
          ordermain.custstate = customer.state 
          ordermain.custname = customer.cname 
          ordermain.shopname = customer.shopname 
          ordermain.save
          @cart.orderdetails.each do |orderdetail|
            orderdetail.ordermain_id = ordermain.id
            orderdetail.save
          end
        end
      end
      ordermain 
    end


    # ...

  protected

    def authorize
      if request.format == Mime::HTML 
        unless Customer.find_by_id(session[:customer_id])
          redirect_to login_url, notice: "Please log in"
        end
      else
        authenticate_or_request_with_http_basic do |username, password|
          #customer = Customer.find_by_loginname(username)
          #customer && customer.authenticate(password)
          Customer.authenticate(username,password)
        end
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = 
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
