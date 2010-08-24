class DistributorsController < ApplicationController
  before_filter :retrieve_country_form_presenter
  
  def index
    @distributors = Distributor.list
  end
  
  def filter
    country_code = params[:country][:country_code]
    @distributors = Distributor.by_country(country_code)
    render :action => 'index'
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
  
private
  def retrieve_country_form_presenter
    @country_form_presenter = CountryFormPresenter.new(:countries => Distributor.country_options, :url => filter_distributors_path, :params => params)
  end
end