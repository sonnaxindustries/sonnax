class ProductLinesController < ApplicationController
  
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
  end
  
  def power_train_savers
    begin
      @product_line = ProductLine.power_train_savers
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