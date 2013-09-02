class OrderinshortsController < ApplicationController
  # GET /orderinshorts
  # GET /orderinshorts.json
  def index
    @orderinshorts = Orderinshort.page(params[:page])
    # @orderinshorts = Orderinshort.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orderinshorts }
    end
  end

end
