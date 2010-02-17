class PrototypesController < ApplicationController
  
  def index
  end
  
  def show
    render :action => params[:name]
  end
  
  def validation
    valid_part_numbers = ['1234', '4567']
    
    if !valid_part_numbers.include?(params[:part_number])
      respond_to do |wants| 
        wants.js 
      end
    else
      respond_to do |wants|
        wants.js
      end
    end
  end
end
