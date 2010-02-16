class PrototypesController < ApplicationController
  
  def index
  end
  
  def show
    render :action => params[:name]
  end
end
