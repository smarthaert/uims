class ProductionpreferencesController < ApplicationController
  # GET /productionpreferences
  # GET /productionpreferences.json
  def index
    @productionpreferences = Productionpreference.page(params[:page])
    # @productionpreferences = Productionpreference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @productionpreferences }
    end
  end

end
