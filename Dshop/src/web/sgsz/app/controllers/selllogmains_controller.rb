class SelllogmainsController < ApplicationController
  # GET /selllogmains
  # GET /selllogmains.json
  def index
    @selllogmains = Selllogmain.page(params[:page])
    # @selllogmains = Selllogmain.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @selllogmains }
    end
  end

  # GET /selllogmains/1
  # GET /selllogmains/1.json
  def show
    @selllogmain = Selllogmain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @selllogmain }
    end
  end

  # GET /selllogmains/new
  # GET /selllogmains/new.json
  def new
    @selllogmain = Selllogmain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selllogmain }
    end
  end

  # GET /selllogmains/1/edit
  def edit
    @selllogmain = Selllogmain.find(params[:id])
  end

  # POST /selllogmains
  # POST /selllogmains.json
  def create
    @selllogmain = Selllogmain.new(params[:selllogmain])

    respond_to do |format|
      if @selllogmain.save
        format.html { redirect_to @selllogmain, notice: t('views.successfully_created') }
        format.json { render json: @selllogmain, status: :created, location: @selllogmain }
      else
        format.html { render action: "new" }
        format.json { render json: @selllogmain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /selllogmains/1
  # PUT /selllogmains/1.json
  def update
    @selllogmain = Selllogmain.find(params[:id])

    respond_to do |format|
      if @selllogmain.update_attributes(params[:selllogmain])
        format.html { redirect_to @selllogmain, notice: t('views.successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @selllogmain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selllogmains/1
  # DELETE /selllogmains/1.json
  def destroy
    @selllogmain = Selllogmain.find(params[:id])
    @selllogmain.destroy

    respond_to do |format|
      format.html { redirect_to selllogmains_url }
      format.json { head :no_content }
    end
  end
end
