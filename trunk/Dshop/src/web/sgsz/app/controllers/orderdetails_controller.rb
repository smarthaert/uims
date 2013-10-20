#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class OrderdetailsController < ApplicationController
    skip_before_filter :authorize, only: :create

  # GET /orderdetails
  # GET /orderdetails.json
  def index
    @orderdetails = Orderdetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orderdetails }
      format.xml { render xml: @orderdetails }
    end
  end

  # GET /orderdetails/1
  # GET /orderdetails/1.json
  def show
    @orderdetail = Orderdetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orderdetail }
    end
  end

  # GET /orderdetails/new
  # GET /orderdetails/new.json
  def new
    @orderdetail = Orderdetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @orderdetail }
    end
  end

  # GET /orderdetails/1/edit
  def edit
    @orderdetail = Orderdetail.find(params[:id])
  end

  # POST /orderdetails
  # POST /orderdetails.json
  def create
    @cart = current_cart
    if params[:orderdetail]
      # ActiveResource
      params[:orderdetail][:ordermain_id] = params[:ordermain_id]
      @orderdetail = Orderdetail.new(params[:orderdetail])
    else
      # HTML forms
      stock = Stock.find(params[:stock_id])
      @orderdetail = @cart.add_product(stock.id, session[:customer_id])
      @orderdetail.pid = stock.pid
      @orderdetail.barcode = stock.barcode
      @orderdetail.goodsname = stock.goodsname
      @orderdetail.size = stock.size
      @orderdetail.color = stock.color
      @orderdetail.volume = stock.volume
      @orderdetail.unit = stock.unit

    end
    #@orderdetail.stock = stock
    @orderdetail.stock_id = stock.id

    respond_to do |format|
      if @orderdetail.save
        format.html { redirect_to store_url }
        format.js   { @current_item = @orderdetail }
        format.json { render json: @orderdetail,
          status: :created, location: @orderdetail }
      else
        format.html { render action: "new" }
        format.json { render json: @orderdetail.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # PUT /orderdetails/1
  # PUT /orderdetails/1.json
  def update
    @orderdetail = Orderdetail.find(params[:id])

    respond_to do |format|
      if @orderdetail.update_attributes(params[:orderdetail])
        format.html { redirect_to @orderdetail, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @orderdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orderdetails/1
  # DELETE /orderdetails/1.json
  def destroy
    @orderdetail = Orderdetail.find(params[:id])
    @orderdetail.destroy

    respond_to do |format|
      format.html { redirect_to orderdetails_url }
      format.json { head :no_content }
    end
  end

  def add
    @orderdetail = Orderdetail.find_by_id(params[:orderdetail_id])
    if @orderdetail
      @orderdetail.amount += 1
    end
    respond_to do |format|
      if @orderdetail.save
        format.html { redirect_to @orderdetail }
        format.js
      else
        format.html { render action: "add" }
        format.js
      end
    end
  end

  def sub
    @orderdetail = Orderdetail.find_by_id(params[:orderdetail_id])
    if @orderdetail
      if @orderdetail.amount > 1
        @orderdetail.amount -= 1
      end
    end
    respond_to do |format|
      if @orderdetail.save
        format.html { redirect_to @orderdetail }
        format.js
      else
        format.html { render action: "sub" }
        format.js
      end
    end
  end

  def del
    @orderdetail = Orderdetail.find_by_id(params[:orderdetail_id])
    respond_to do |format|
      if @orderdetail.destroy
        format.html { redirect_to @orderdetail }
        format.js
      else
        format.html { render action: "del" }
        format.js
      end
    end
  end
end

