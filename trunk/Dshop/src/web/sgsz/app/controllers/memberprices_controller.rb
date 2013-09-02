class MemberpricesController < ApplicationController
  # GET /memberprices
  # GET /memberprices.json
  def index
    @memberprices = Memberprice.page(params[:page])
    # @memberprices = Memberprice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberprices }
    end
  end

  # GET /memberprices/1
  # GET /memberprices/1.json
  def show
    @memberprice = Memberprice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @memberprice }
    end
  end

  # GET /memberprices/new
  # GET /memberprices/new.json
  def new
    @memberprice = Memberprice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @memberprice }
    end
  end

  # GET /memberprices/1/edit
  def edit
    @memberprice = Memberprice.find(params[:id])
  end

  # POST /memberprices
  # POST /memberprices.json
  def create
    @memberprice = Memberprice.new(params[:memberprice])

    respond_to do |format|
      if @memberprice.save
        format.html { redirect_to @memberprice, notice: 'Memberprice was successfully created.' }
        format.json { render json: @memberprice, status: :created, location: @memberprice }
      else
        format.html { render action: "new" }
        format.json { render json: @memberprice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /memberprices/1
  # PUT /memberprices/1.json
  def update
    @memberprice = Memberprice.find(params[:id])

    respond_to do |format|
      if @memberprice.update_attributes(params[:memberprice])
        format.html { redirect_to @memberprice, notice: 'Memberprice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @memberprice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberprices/1
  # DELETE /memberprices/1.json
  def destroy
    @memberprice = Memberprice.find(params[:id])
    @memberprice.destroy

    respond_to do |format|
      format.html { redirect_to memberprices_url }
      format.json { head :no_content }
    end
  end
end
