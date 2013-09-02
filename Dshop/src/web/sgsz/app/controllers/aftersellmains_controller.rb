class AftersellmainsController < ApplicationController
  # GET /aftersellmains
  # GET /aftersellmains.json
  def index
    @aftersellmains = Aftersellmain.page(params[:page])
    # @aftersellmains = Aftersellmain.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aftersellmains }
    end
  end

  # GET /aftersellmains/1
  # GET /aftersellmains/1.json
  def show
    @aftersellmain = Aftersellmain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aftersellmain }
    end
  end

  # GET /aftersellmains/new
  # GET /aftersellmains/new.json
  def new
    @aftersellmain = Aftersellmain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aftersellmain }
    end
  end

  # GET /aftersellmains/1/edit
  def edit
    @aftersellmain = Aftersellmain.find(params[:id])
  end

  # POST /aftersellmains
  # POST /aftersellmains.json
  def create
    @aftersellmain = Aftersellmain.new(params[:aftersellmain])

    respond_to do |format|
      if @aftersellmain.save
        format.html { redirect_to @aftersellmain, notice: 'Aftersellmain was successfully created.' }
        format.json { render json: @aftersellmain, status: :created, location: @aftersellmain }
      else
        format.html { render action: "new" }
        format.json { render json: @aftersellmain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aftersellmains/1
  # PUT /aftersellmains/1.json
  def update
    @aftersellmain = Aftersellmain.find(params[:id])

    respond_to do |format|
      if @aftersellmain.update_attributes(params[:aftersellmain])
        format.html { redirect_to @aftersellmain, notice: 'Aftersellmain was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aftersellmain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aftersellmains/1
  # DELETE /aftersellmains/1.json
  def destroy
    @aftersellmain = Aftersellmain.find(params[:id])
    @aftersellmain.destroy

    respond_to do |format|
      format.html { redirect_to aftersellmains_url }
      format.json { head :no_content }
    end
  end
end
