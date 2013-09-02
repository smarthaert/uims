class SelllogdetailsController < ApplicationController
  # GET /selllogdetails
  # GET /selllogdetails.json
  def index
    @selllogdetails = Selllogdetail.page(params[:page])
    # @selllogdetails = Selllogdetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @selllogdetails }
    end
  end

  # GET /selllogdetails/1
  # GET /selllogdetails/1.json
  def show
    @selllogdetail = Selllogdetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @selllogdetail }
    end
  end

  # GET /selllogdetails/new
  # GET /selllogdetails/new.json
  def new
    @selllogdetail = Selllogdetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selllogdetail }
    end
  end

  # GET /selllogdetails/1/edit
  def edit
    @selllogdetail = Selllogdetail.find(params[:id])
  end

  # POST /selllogdetails
  # POST /selllogdetails.json
  def create
    @selllogdetail = Selllogdetail.new(params[:selllogdetail])

    respond_to do |format|
      if @selllogdetail.save
        format.html { redirect_to @selllogdetail, notice: 'Selllogdetail was successfully created.' }
        format.json { render json: @selllogdetail, status: :created, location: @selllogdetail }
      else
        format.html { render action: "new" }
        format.json { render json: @selllogdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /selllogdetails/1
  # PUT /selllogdetails/1.json
  def update
    @selllogdetail = Selllogdetail.find(params[:id])

    respond_to do |format|
      if @selllogdetail.update_attributes(params[:selllogdetail])
        format.html { redirect_to @selllogdetail, notice: 'Selllogdetail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @selllogdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selllogdetails/1
  # DELETE /selllogdetails/1.json
  def destroy
    @selllogdetail = Selllogdetail.find(params[:id])
    @selllogdetail.destroy

    respond_to do |format|
      format.html { redirect_to selllogdetails_url }
      format.json { head :no_content }
    end
  end
end
