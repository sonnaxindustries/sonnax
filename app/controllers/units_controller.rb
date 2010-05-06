class UnitsController < ApplicationController
  def index
    @units = Unit.list
  end

  def show
    begin
      @unit = Unit.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end