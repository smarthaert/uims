class OrdermainsController < ApplicationController
  # GET /ordermains
  # GET /ordermains.json
  def index
    @ordermains = Ordermain.page(params[:page])
    # @ordermains = Ordermain.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ordermains }
    end
  end

  # GET /ordermains/1
  # GET /ordermains/1.json
  def show
    @ordermain = Ordermain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ordermain }
    end
  end

  # GET /ordermains/new
  # GET /ordermains/new.json
  def new
    @ordermain = Ordermain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ordermain }
    end
  end

  # GET /ordermains/1/edit
  def edit
    @ordermain = Ordermain.find(params[:id])
  end

  # POST /ordermains
  # POST /ordermains.json
  def create
    @ordermain = Ordermain.new(params[:ordermain])

    respond_to do |format|
      if @ordermain.save
        format.html { redirect_to @ordermain, notice: 'Ordermain was successfully created.' }
        format.json { render json: @ordermain, status: :created, location: @ordermain }
      else
        format.html { render action: "new" }
        format.json { render json: @ordermain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ordermains/1
  # PUT /ordermains/1.json
  def update
    @ordermain = Ordermain.find(params[:id])

    respond_to do |format|
      if @ordermain.update_attributes(params[:ordermain])
        format.html { redirect_to @ordermain, notice: 'Ordermain was successfully updated.' }
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
end
