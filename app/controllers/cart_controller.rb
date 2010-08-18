class CartController < ApplicationController
  
  def show
    @cart = find_cart
    @order = Order.new
    @shipping_types = Order.shipping_method_options
  end
  
  def checkout
  end
  
  def add_speed_order
    @cart = find_cart
    @cart.add_from_speed_order(params[:speed_order])
    redirect_to(cart_path)
  end
  
  def add_multiple
    @cart = find_cart
    @cart.add_multiple_parts(params[:cart])
    redirect_to(cart_path)
  end
  
  def remove
    begin
      part = Part.find(params[:part_id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = 'Invalid Part'
      redirect_to(cart_path)
    else
      @cart = find_cart
      @cart.remove_part(part)

      respond_to do |wants|
        wants.html 
        wants.json do 
          render :json => {
            :dom_id => dom_id(part, :line_item)
          }
        end
      end
    end
  end
  
  def add
    begin
      part = Part.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = 'Invalid Part'
      redirect_to(cart_path)
    else
      @cart = find_cart
      @cart.add_product(part)
    end
  end
  
  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Your cart is currently empty" 
    redirect_to(cart_path)
  end
end
