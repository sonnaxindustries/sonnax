class CatalogRequestsController < ApplicationController
  before_filter :retrieve_catalogs
  
  def new
    @catalog_request = CatalogRequest.new
  end
  
  def create
    begin
      @catalog_request = CatalogRequest.new(params[:catalog_request])
      @catalog_request.save!
      flash_and_redirect(thanks_catalog_request_path, 'Thanks for contacting us to request catalogs!')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end

  def thanks
  end
  
private
  def retrieve_catalogs
    @catalogs = CatalogRequest.catalogs
  end
end