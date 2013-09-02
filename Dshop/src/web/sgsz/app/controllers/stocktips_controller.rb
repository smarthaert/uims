class StocktipsController < ApplicationController
  # GET /stocktips
  # GET /stocktips.json
  def index
    @stocktips = Stocktip.page(params[:page])
    # @stocktips = Stocktip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stocktips }
    end
  end

end
