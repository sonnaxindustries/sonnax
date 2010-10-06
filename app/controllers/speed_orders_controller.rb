class SpeedOrdersController < ApplicationController
  def new
    @cart = find_cart
    @speed_order = SpeedOrder.new
    @product_line_options = ProductLine.speed_order_options
    @selected_product_line = ProductLine.torque_converter
  end
  
  def create
    @cart = find_cart
    @cart.add_multiple_speed_order_parts(params[:speed_order])
    redirect_to(cart_path)
  end
end
