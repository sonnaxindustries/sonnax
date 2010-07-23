class PartsController < ApplicationController
  before_filter :retrieve_product_line
  
  def index
    @parts = @product_line.parts
    
    presenter_object = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = presenter_object.constantize.new(:parts => @parts, :makes => Make.all(:limit => 10), :units => Unit.all(:limit => 10))
    
    search_path = search_product_line_parts_path(@product_line.url_friendly)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)
    
    template_file = "parts/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def recent
    @parts = @product_line.parts.recent
    template_file = "parts/index_by_product_line/recent/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def search
    search_term = params[:search][:q]
    @parts = Part.search(params[:search][:q], :with => { :product_line_id => @product_line.id })
    
    presenter_object = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = presenter_object.constantize.new(:parts => @parts, :makes => Make.all(:limit => 10), :units => Unit.all(:limit => 10))
    
    search_path = search_product_line_parts_path(@product_line.url_friendly)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => search_term, :url => search_path)
    
    template_file = "parts/index_by_product_line/search/%s" % [@product_line.url_friendly.underscore]
    
    respond_to do |wants|
      wants.html do
        render template_file
      end
      wants.json do
      end
    end
  end

  def show
    begin
      @part = @product_line.parts.find(params[:id])
      template_file = "parts/show_by_product_line/%s" % [@product_line.url_friendly.underscore]
      render template_file
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
private
  def retrieve_product_line
    begin
      @product_line = ProductLine.detail!(params[:product_line_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
