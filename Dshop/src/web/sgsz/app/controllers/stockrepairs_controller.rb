class StockrepairsController < ApplicationController
  # GET /stockrepairs
  # GET /stockrepairs.json
  def index
    @stockrepairs = Stockrepair.page(params[:page])
    # @stockrepairs = Stockrepair.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stockrepairs }
    end
  end

end
