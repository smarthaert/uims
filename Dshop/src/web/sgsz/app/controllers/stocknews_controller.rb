class StocknewsController < ApplicationController
  # GET /stocknews
  # GET /stocknews.json
  def index
    @stocknews = Stocknew.page(params[:page])
    # @stocknews = Stocknew.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stocknews }
    end
  end

  
end
