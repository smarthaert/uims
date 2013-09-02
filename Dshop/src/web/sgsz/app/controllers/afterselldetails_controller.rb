class AfterselldetailsController < ApplicationController
  # GET /afterselldetails
  # GET /afterselldetails.json
  def index
    @afterselldetails = Afterselldetail.page(params[:page])
    # @afterselldetails = Afterselldetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @afterselldetails }
    end
  end

  # GET /afterselldetails/1
  # GET /afterselldetails/1.json
  def show
    @afterselldetail = Afterselldetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @afterselldetail }
    end
  end

  # GET /afterselldetails/new
  # GET /afterselldetails/new.json
  def new
    @afterselldetail = Afterselldetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @afterselldetail }
    end
  end

  # GET /afterselldetails/1/edit
  def edit
    @afterselldetail = Afterselldetail.find(params[:id])
  end

  # POST /afterselldetails
  # POST /afterselldetails.json
  def create
    @afterselldetail = Afterselldetail.new(params[:afterselldetail])

    respond_to do |format|
      if @afterselldetail.save
        format.html { redirect_to @afterselldetail, notice: 'Afterselldetail was successfully created.' }
        format.json { render json: @afterselldetail, status: :created, location: @afterselldetail }
      else
        format.html { render action: "new" }
        format.json { render json: @afterselldetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /afterselldetails/1
  # PUT /afterselldetails/1.json
  def update
    @afterselldetail = Afterselldetail.find(params[:id])

    respond_to do |format|
      if @afterselldetail.update_attributes(params[:afterselldetail])
        format.html { redirect_to @afterselldetail, notice: 'Afterselldetail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @afterselldetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /afterselldetails/1
  # DELETE /afterselldetails/1.json
  def destroy
    @afterselldetail = Afterselldetail.find(params[:id])
    @afterselldetail.destroy

    respond_to do |format|
      format.html { redirect_to afterselldetails_url }
      format.json { head :no_content }
    end
  end
end
