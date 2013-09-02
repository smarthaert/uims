class OrderstatesController < ApplicationController
  # GET /orderstates
  # GET /orderstates.json
  def index
    @orderstates = Orderstate.page(params[:page])
    # @orderstates = Orderstate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orderstates }
    end
  end

end
