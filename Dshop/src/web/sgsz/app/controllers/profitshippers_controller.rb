class ProfitshippersController < ApplicationController
  # GET /profitshippers
  # GET /profitshippers.json
  def index
    @profitshippers = Profitshipper.page(params[:page])
    # @profitshippers = Profitshipper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profitshippers }
    end
  end

end
