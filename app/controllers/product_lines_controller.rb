class ProductLinesController < ApplicationController
  
  def order_info
    begin
      @product_line = ProductLine.detail!(params[:id])
      render :template => 'pages/order_info'
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def transmission
    begin
      @product_line = ProductLine.transmission
    rescue ActiveRecord::RecordNotFound 
      render_404
    end
  end
  
  def torque_converter
    begin
      @product_line = ProductLine.torque_converter
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def harley_davidson
  end
  
  def harley_davidson_parts
    params.reverse_merge!(:format => 'html') unless params[:format]
    respond_to do |wants|
      wants.html
      wants.print do
        render :template => "product_lines/harley_davidson_parts.html.erb", :layout => 'print.html.erb'
      end
    end
  end
  
  def power_train_savers
    begin
      @product_line = ProductLine.power_train_savers
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end

  def ring_gears_millimeter_parts
    begin
      @product_line = ProductLine.ring_gears
      params.reverse_merge!(:format => 'html') unless params[:format]

      respond_to do |wants|
        wants.html
        wants.print do
          render :template => "product_lines/ring_gears_millimeter_parts.html.erb", :layout => 'print.html.erb'
        end
      end

    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end

  def ring_gears_inches_parts
    begin
      @product_line = ProductLine.ring_gears
      params.reverse_merge!(:format => 'html') unless params[:format]

      respond_to do |wants|
        wants.html
        wants.print do
          render :template => "product_lines/ring_gears_inches_parts.html.erb", :layout => 'print.html.erb'
        end
      end

    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end
  
  def ring_gears
    begin
      @product_line = ProductLine.ring_gears
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end
  
  def high_performance_transmission
    begin
      @product_line = ProductLine.high_performance_transmission
    rescue ActiveRecord::RecordNotFound
      render_404  
    end
  end
  
  def power_train_savers_parts
    params.reverse_merge!(:format => 'html') unless params[:format]
    begin
      @product_line = ProductLine.power_train_savers
      respond_to do |wants|
        wants.html
        wants.print do
          render :template => "product_lines/power_train_savers_parts.html.erb", :layout => 'print.html.erb'
        end
      end
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def driveline_parts
    params.reverse_merge!(:format => 'html') unless params[:format]
    begin
      @product_line = ProductLine.driveline
      respond_to do |wants|
        wants.html
        wants.print do
          render :template => "product_lines/driveline_parts.html.erb", :layout => 'print.html.erb'
        end
      end
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def driveline
    begin
      @product_line = ProductLine.driveline
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def allison
    begin
      @product_line = ProductLine.allison
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
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
