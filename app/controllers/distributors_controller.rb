class DistributorsController < ApplicationController
  def index
    @distributors = Distributor.list
  end
  
  def filter_by_country
    @distributors = Distributor.by_country(params[:country_code])
    render :action => 'index'
  end
  
  def filter_by_city
    @distributors = Distributor.by_city(params[:city_name])
    render :action => 'index'
  end
  
  def filter_by_state
    @distributors = Distributor.by_state(params[:state_code])
    render :action => 'index'
  end

  def show
    begin
      @distributor = Distributor.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end