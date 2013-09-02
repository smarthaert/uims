class SellcostgiftsController < ApplicationController
  # GET /sellcostgifts
  # GET /sellcostgifts.json
  def index
    @sellcostgifts = Sellcostgift.page(params[:page])
    # @sellcostgifts = Sellcostgift.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sellcostgifts }
    end
  end

  
end
