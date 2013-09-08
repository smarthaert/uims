class OrderdetailsController < ApplicationController
  # GET /orderdetails
  # GET /orderdetails.json
  def index
    @orderdetails = Orderdetail.page(params[:page])
    # @orderdetails = Orderdetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orderdetails }
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
    @orderdetail = Orderdetail.new(params[:orderdetail])

    respond_to do |format|
      if @orderdetail.save
        format.html { redirect_to @orderdetail, notice: t('views.successfully_created') }
        format.json { render json: @orderdetail, status: :created, location: @orderdetail }
      else
        format.html { render action: "new" }
        format.json { render json: @orderdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orderdetails/1
  # PUT /orderdetails/1.json
  def update
    @orderdetail = Orderdetail.find(params[:id])

    respond_to do |format|
      if @orderdetail.update_attributes(params[:orderdetail])
        format.html { redirect_to @orderdetail, notice: t('views.successfully_updated') }
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
end
