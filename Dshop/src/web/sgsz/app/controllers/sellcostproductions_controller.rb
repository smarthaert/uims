class SellcostproductionsController < ApplicationController
  # GET /sellcostproductions
  # GET /sellcostproductions.json
  def index
    @sellcostproductions = Sellcostproduction.page(params[:page])
    # @sellcostproductions = Sellcostproduction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sellcostproductions }
    end
  end

  
end
