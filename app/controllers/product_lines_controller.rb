class ProductLinesController < ApplicationController
  
  def index
    @product_lines = ProductLine.list
  end

  def show
    begin
      @product_line = ProductLine.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end