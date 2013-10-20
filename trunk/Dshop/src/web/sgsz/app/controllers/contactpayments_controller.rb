class ContactpaymentsController < ApplicationController
  # GET /contactpayments
  # GET /contactpayments.json
  def index
    #@contactpayments = Contactpayment.all
    customer = Customer.find_by_id(session[:customer_id])
    @contactpayments = Contactpayment.where("custid = ?", customer.cid).order("created_at desc").page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contactpayments }
    end
  end

  # GET /contactpayments/1
  # GET /contactpayments/1.json
  def show
    @contactpayment = Contactpayment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contactpayment }
    end
  end

  # GET /contactpayments/new
  # GET /contactpayments/new.json
  def new
    @contactpayment = Contactpayment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contactpayment }
    end
  end

  # GET /contactpayments/1/edit
  def edit
    @contactpayment = Contactpayment.find(params[:id])
  end

  # POST /contactpayments
  # POST /contactpayments.json
  def create
    @contactpayment = Contactpayment.new(params[:contactpayment])

    respond_to do |format|
      if @contactpayment.save
        format.html { redirect_to @contactpayment, notice: 'Contactpayment was successfully created.' }
        format.json { render json: @contactpayment, status: :created, location: @contactpayment }
      else
        format.html { render action: "new" }
        format.json { render json: @contactpayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contactpayments/1
  # PUT /contactpayments/1.json
  def update
    @contactpayment = Contactpayment.find(params[:id])

    respond_to do |format|
      if @contactpayment.update_attributes(params[:contactpayment])
        format.html { redirect_to @contactpayment, notice: 'Contactpayment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contactpayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactpayments/1
  # DELETE /contactpayments/1.json
  def destroy
    @contactpayment = Contactpayment.find(params[:id])
    @contactpayment.destroy

    respond_to do |format|
      format.html { redirect_to contactpayments_url }
      format.json { head :no_content }
    end
  end
end
