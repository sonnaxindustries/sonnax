class MakesController < ApplicationController
  
  def index
    @makes = Make.list
  end

  def show
    begin
      @make = Make.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end