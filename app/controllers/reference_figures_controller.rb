class ReferenceFiguresController < ApplicationController
  def index
    @reference_figures = ReferenceFigure.list
  end

  def show
    begin
      @reference_figure = ReferenceFigure.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
    end
  end
end