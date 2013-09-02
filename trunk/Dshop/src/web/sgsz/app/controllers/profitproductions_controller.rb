class ProfitproductionsController < ApplicationController
  # GET /profitproductions
  # GET /profitproductions.json
  def index
    @profitproductions = Profitproduction.page(params[:page])
    # @profitproductions = Profitproduction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profitproductions }
    end
  end

end
