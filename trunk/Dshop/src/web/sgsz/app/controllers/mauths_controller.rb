class MauthsController < ApplicationController
  # GET /mauths
  # GET /mauths.json
  def index
    @mauths = Mauth.page(params[:page])
    # @mauths = Mauth.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mauths }
    end
  end

  # GET /mauths/1
  # GET /mauths/1.json
  def show
    @mauth = Mauth.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mauth }
    end
  end

  # GET /mauths/new
  # GET /mauths/new.json
  def new
    @mauth = Mauth.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mauth }
    end
  end

  # GET /mauths/1/edit
  def edit
    @mauth = Mauth.find(params[:id])
  end

  # POST /mauths
  # POST /mauths.json
  def create
    @mauth = Mauth.new(params[:mauth])

    respond_to do |format|
      if @mauth.save
        format.html { redirect_to @mauth, notice: 'Mauth was successfully created.' }
        format.json { render json: @mauth, status: :created, location: @mauth }
      else
        format.html { render action: "new" }
        format.json { render json: @mauth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mauths/1
  # PUT /mauths/1.json
  def update
    @mauth = Mauth.find(params[:id])

    respond_to do |format|
      if @mauth.update_attributes(params[:mauth])
        format.html { redirect_to @mauth, notice: 'Mauth was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mauth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mauths/1
  # DELETE /mauths/1.json
  def destroy
    @mauth = Mauth.find(params[:id])
    @mauth.destroy

    respond_to do |format|
      format.html { redirect_to mauths_url }
      format.json { head :no_content }
    end
  end
end
