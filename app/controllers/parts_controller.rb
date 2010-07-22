class PartsController < ApplicationController
  before_filter :retrieve_product_line
  
  def index
    @parts = @product_line.parts
  end
  
  def recent
    @parts = @product_line.parts.recent
  end

  def show
    begin
      @part = @product_line.parts.find_by_url_friendly!(params[:id])
      template_file = "parts/by_product_line/%s" % [@product_line.url_friendly.underscore]
      render template_file
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
