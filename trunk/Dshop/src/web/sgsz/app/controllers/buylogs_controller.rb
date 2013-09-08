class BuylogsController < ApplicationController
  # GET /buylogs
  # GET /buylogs.json
  def index
    @buylogs = Buylog.page(params[:page])
    # @buylogs = Buylog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buylogs }
    end
  end

  # GET /buylogs/1
  # GET /buylogs/1.json
  def show
    @buylog = Buylog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @buylog }
    end
  end

  # GET /buylogs/new
  # GET /buylogs/new.json
  def new
    @buylog = Buylog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @buylog }
    end
  end

  # GET /buylogs/1/edit
  def edit
    @buylog = Buylog.find(params[:id])
  end

  # POST /buylogs
  # POST /buylogs.json
  def create
    @buylog = Buylog.new(params[:buylog])

    respond_to do |format|
      if @buylog.save
        format.html { redirect_to @buylog, notice: t('views.successfully_created') }
        format.json { render json: @buylog, status: :created, location: @buylog }
      else
        format.html { render action: "new" }
        format.json { render json: @buylog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buylogs/1
  # PUT /buylogs/1.json
  def update
    @buylog = Buylog.find(params[:id])

    respond_to do |format|
      if @buylog.update_attributes(params[:buylog])
        format.html { redirect_to @buylog, notice: t('views.successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @buylog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buylogs/1
  # DELETE /buylogs/1.json
  def destroy
    @buylog = Buylog.find(params[:id])
    @buylog.destroy

    respond_to do |format|
      format.html { redirect_to buylogs_url }
      format.json { head :no_content }
    end
  end
end
