class FeedersController < ApplicationController
  # GET /feeders
  # GET /feeders.json
  def index
    @feeders = Feeder.page(params[:page])
    # @feeders = Feeder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeders }
    end
  end

  # GET /feeders/1
  # GET /feeders/1.json
  def show
    @feeder = Feeder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feeder }
    end
  end

  # GET /feeders/new
  # GET /feeders/new.json
  def new
    @feeder = Feeder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feeder }
    end
  end

  # GET /feeders/1/edit
  def edit
    @feeder = Feeder.find(params[:id])
  end

  # POST /feeders
  # POST /feeders.json
  def create
    @feeder = Feeder.new(params[:feeder])

    respond_to do |format|
      if @feeder.save
        format.html { redirect_to @feeder, notice: t('views.successfully_created') }
        format.json { render json: @feeder, status: :created, location: @feeder }
      else
        format.html { render action: "new" }
        format.json { render json: @feeder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feeders/1
  # PUT /feeders/1.json
  def update
    @feeder = Feeder.find(params[:id])

    respond_to do |format|
      if @feeder.update_attributes(params[:feeder])
        format.html { redirect_to @feeder, notice: t('views.successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feeder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeders/1
  # DELETE /feeders/1.json
  def destroy
    @feeder = Feeder.find(params[:id])
    @feeder.destroy

    respond_to do |format|
      format.html { redirect_to feeders_url }
      format.json { head :no_content }
    end
  end
end
