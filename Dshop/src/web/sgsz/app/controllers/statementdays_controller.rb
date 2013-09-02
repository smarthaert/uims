class StatementdaysController < ApplicationController
  # GET /statementdays
  # GET /statementdays.json
  def index
    @statementdays = Statementday.page(params[:page])
    # @statementdays = Statementday.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statementdays }
    end
  end

 
end
