class ProfitcustomersController < ApplicationController
  # GET /profitcustomers
  # GET /profitcustomers.json
  def index
    @profitcustomers = Profitcustomer.page(params[:page])
    # @profitcustomers = Profitcustomer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profitcustomers }
    end
  end

end
