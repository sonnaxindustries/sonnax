class PartsController < ApplicationController
  before_filter :retrieve_product_line
  
  def index
    #@parts = @product_line.parts
  end

  def show
    # NOTE: The rendered view will be a partial based on the product_line 
    begin
      @part = @product_lines.parts.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
private
  def retrieve_product_line
    begin
      @product_line = ProductLine.detail!(params[:product_line_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
