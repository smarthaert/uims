class ShippersController < ApplicationController
  # GET /shippers
  # GET /shippers.json
  def index
    @shippers = Shipper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shippers }
    end
  end

  # GET /shippers/1
  # GET /shippers/1.json
  def show
    @shipper = Shipper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shipper }
    end
  end

  # GET /shippers/new
  # GET /shippers/new.json
  def new
    @shipper = Shipper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shipper }
    end
  end

  # GET /shippers/1/edit
  def edit
    @shipper = Shipper.find(params[:id])
  end

  # POST /shippers
  # POST /shippers.json
  def create
    @shipper = Shipper.new(params[:shipper])

    respond_to do |format|
      if @shipper.save
        format.html { redirect_to @shipper, notice: 'Shipper was successfully created.' }
        format.json { render json: @shipper, status: :created, location: @shipper }
      else
        format.html { render action: "new" }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shippers/1
  # PUT /shippers/1.json
  def update
    @shipper = Shipper.find(params[:id])

    respond_to do |format|
      if @shipper.update_attributes(params[:shipper])
        format.html { redirect_to @shipper, notice: 'Shipper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shippers/1
  # DELETE /shippers/1.json
  def destroy
    @shipper = Shipper.find(params[:id])
    @shipper.destroy

    respond_to do |format|
      format.html { redirect_to shippers_url }
      format.json { head :no_content }
    end
  end
end
