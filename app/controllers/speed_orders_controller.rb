class SpeedOrdersController < ApplicationController
  
  def new
    @cart = find_cart
    @speed_order = SpeedOrder.new
    @product_line_options = ProductLine.speed_order_options
    @selected_product_line = retrieve_selected_product_line 
  end
  
  def create
    @cart = find_cart
    @cart.add_multiple_speed_order_parts(params[:speed_order])
    
    if @cart.valid?
      redirect_to(cart_path)
    else
      @cart = find_cart
      @speed_order = SpeedOrder.new
      @product_line_options = ProductLine.speed_order_options
      @selected_product_line = ProductLine.find(params[:speed_order][:product_line_id])
      flash[:errors] = @cart.errors
      redirect_to(cart_path)
    end
  end
private
  def retrieve_selected_product_line
    begin
      ProductLine.find_by_id!(params[:from])
    rescue ActiveRecord::RecordNotFound
      ProductLine.torque_converter
    end
  end
end
