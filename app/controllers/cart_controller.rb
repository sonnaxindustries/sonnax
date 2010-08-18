class CartController < ApplicationController
  before_filter :retrieve_cart, :only => [:show, :checkout]
  before_filter :retrieve_shipping_options, :only => [:show, :checkout]
  
  def show
    @order = Order.new
  end
  
  def checkout
    begin
      @order = Order.new(params[:order])
      @order.save!
      
      session[:cart] = nil
      
      respond_to do |wants|
        wants.html do
          redirect_to(thanks_cart_path)
        end
      end
    rescue ActiveRecord::RecordInvalid
      render :action => 'show'
    end
  end
  
  def update
    @cart = find_cart
    @cart.update_parts!(params[:order][:part_groups])
    
    respond_to do |wants|
      wants.html do
        redirect_to(cart_path)
      end
      wants.json
    end
  end
  
  def thanks
  end
  
  def add_speed_order
    @cart = find_cart
    @cart.add_multiple_speed_order_parts(params[:speed_order])
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
  
private
  def retrieve_cart
    @cart = find_cart
  end
  
  def retrieve_shipping_options
    @shipping_types = Order.shipping_method_options
  end
end
