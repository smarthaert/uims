class SellcostcustomersController < ApplicationController
  # GET /sellcostcustomers
  # GET /sellcostcustomers.json
  def index
    @sellcostcustomers = Sellcostcustomer.page(params[:page])
    # @sellcostcustomers = Sellcostcustomer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sellcostcustomers }
    end
  end

  
end
