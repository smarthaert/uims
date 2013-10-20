#encoding: utf-8
#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class OrdermainsController < ApplicationController
  #skip_before_filter :authorize, only: [:new, :create]

  # GET /ordermains
  # GET /ordermains.json
  def index
#    @ordermains = Ordermain.paginate :page => params[:page],      
#                               :per_page => 100,    
#                               :conditions => ["name like ? or cell_phone like ? or teller like ? or created_at like ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%"]
#    @sum = []
#    @ordermains.each {
#      |ordermain|
#      @sum[0] = ordermain.integration.to_i + @sum[0].to_i
#      @sum[1] = ordermain.discount.to_i + @sum[1].to_i
#    }
    @ordermains = Ordermain.where("customer_id = ? and oid like ? and sname like ?", session[:customer_id], "%#{params[:oid]}%", "%#{params[:sname]}%").order("created_at desc").page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @ordermains }
    end
  end

  # GET /ordermains/1
  # GET /ordermains/1.json
  def show
    @ordermain = Ordermain.find(params[:id])
    @orderdetals = @ordermain.orderdetails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ordermain }
    end
  end


  # GET /ordermains/new
  # GET /ordermains/new.json
  def new
    @cart = current_cart
    if @cart.orderdetails.empty?
      redirect_to store_url, notice: t('your_cart_is_empty')
      return
    end
    @ordermain = current_ordermain
    customer = Customer.find_by_id(session[:customer_id])
    @ordermain.custid = customer.cid
    @ordermain.custname = customer.loginname
    @ordermain.shopname = customer.shopname
    @ordermain.custtel = customer.tel
    @ordermain.custaddr = customer.address
    @ordermain.custstate = customer.state
   
    #@shipper = Shipper.find_by_id(session[:shipper_id]) 
    @shipper = Shipper.find_by_id(@ordermain.sid) 
    @shippers = Shipper.all

    #@orderdetails = @ordermain.orderdetails
    @orderdetails = @cart.orderdetails

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ordermain }
    end
  end

  # GET /orders/1/edit
  def edit
    @cart = current_cart
    if @cart
      @cart.destroy
    end
    session[:cart_id] = nil
    @cart = current_cart
    @ordermain = Ordermain.find(params[:id])
    @ordermain.orderdetails.each do |orderdetail|
      orderdetail.cart_id = @cart.id
      orderdetail.save
    end
    session[:shipper_id] = @ordermain.sid
    @ordermain.dtype = ''
    @ordermain.save

    respond_to do |format|
      format.html { redirect_to new_ordermain_url } 
      format.json { render json: @ordermain }
    end
  end

  # POST /ordermains
  # POST /ordermains.json
  def update 
    #@ordermain = Ordermain.new(params[:order])
    @ordermain = current_ordermain
    customer = Customer.find_by_id(session[:customer_id])
    @ordermain.customer_id = customer.id 
    @ordermain.custtel = params[:ordermain][:custtel] 
    @ordermain.sid = params[:shipper][:id] 
    @ordermain.custaddr = params[:ordermain][:custaddr] 
    @ordermain.remark = params[:ordermain][:remark] 
    @ordermain.add_orderdetails_from_cart(current_cart)
    @ordermain.status = 0
    @ordermain.dtype = "提交" 
    om = Ordermain.find_by_sql('select (select concat("N",DATE_FORMAT(now(),"%y%m%d"),lpad(cast(substr(if(max(oid) is null,"0000",max(oid)),8) as signed) + 1,4,"0")) as id from ordermains where DATE_FORMAT(created_at,"%y%m%d")=DATE_FORMAT(now(),"%y%m%d") and oid like "N%") as oid from ordermains limit 1').first
    @ordermain.oid = om.oid
    #@ordermain.custid = customer.cid
    #@ordermain.custname = customer.cname
    #@ordermain.shopname = customer.shopname
    #@ordermain.custstate = customer.state
    @ordermain.orderdetails.each do |orderdetail|
      orderdetail.oid = om.oid
      orderdetail.save
    end
    
    respond_to do |format|
      if @ordermain.save
        @cart = current_cart
        if @cart
          @cart.destroy
        end
        session[:cart_id] = nil
        session[:shipper_id] = nil 
        OrderNotifier.received(@ordermain).deliver
        format.html { redirect_to ordermains_close_url, notice: 
          I18n.t('.thanks') }
        format.json { render json: @ordermain, status: :created,
          location: @ordermain }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @ordermain.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /ordermains/1
  # PUT /ordersmain/1.json
  def create 
    @ordermain = Ordermain.find(params[:id])

    respond_to do |format|
      if @ordermain.update_attributes(params[:ordermain])
        format.html { redirect_to @ordermain, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ordermain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordermains/1
  # DELETE /ordermains/1.json
  def destroy
    @ordermain = Ordermain.find(params[:id])
    @ordermain.destroy

    respond_to do |format|
      format.html { redirect_to ordermains_url }
      format.json { head :no_content }
    end
  end

  def open

  end


  def close 
    #@ordermains = Ordermain.paginate :page => params[:page],      
    #                           :per_page => 100,    
    #                           #:conditions => ["status is null and customer_id = ?", "1"]
    #                           :conditions => ["status is null and custid = ?", "#{session[:customer_id]}"]
    @ordermains = Ordermain.where("customer_id = ? and dtype <> ''", session[:customer_id]).order("created_at desc").page params[:page]
    #@ordermains = Ordermain.where("customer_id = ? and oid like ? and sname like ?", session[:customer_id], "%#{params[:oid]}%", "%#{params[:sname]}%").order("created_at desc").page params[:page]
    respond_to do |format|
      format.html { render action: "index" } 
      format.xml { render xml: @ordermains }
   end

  end
end
