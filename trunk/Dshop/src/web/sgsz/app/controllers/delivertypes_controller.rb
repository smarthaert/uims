class DelivertypesController < ApplicationController
  # GET /delivertypes
  # GET /delivertypes.json
  def index
    @delivertypes = Delivertype.page(params[:page])
    # @delivertypes = Delivertype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @delivertypes }
    end
  end

end
