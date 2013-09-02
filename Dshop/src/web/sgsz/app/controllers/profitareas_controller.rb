class ProfitareasController < ApplicationController
  # GET /profitareas
  # GET /profitareas.json
  def index
    @profitareas = Profitarea.page(params[:page])
    # @profitareas = Profitarea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profitareas }
    end
  end

 
end
