class PartsController < ApplicationController
  before_filter :retrieve_product_line
  
  def index
    @parts = @product_line.parts
    
    @makes = @product_line.associated_makes
    @units = @product_line.associated_units
    
    presenter_object = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = presenter_object.constantize.new(:product_line => @product_line, :parts => @parts, :makes => @makes, :units => @units)
    
    search_path = search_product_line_parts_path(@product_line.url_friendly)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)
    
    template_file = "parts/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def filter
    @makes = @product_line.associated_makes
    @units = @product_line.associated_units
    @unit_options = @product_line.unit_options.unshift(['-- Select Unit --', ''])
    
    if params[:filter] && !params[:filter][:make].blank?
      @unit_options = @product_line.unit_options(:make => params[:filter].fetch('make')).unshift(['-- Select Unit --', ''])
    end
        
    params[:filter].merge!(:product_line => @product_line) if params[:filter]
    @parts = Part.find_by_filter(params[:filter] || {})
    
    presenter_object = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = presenter_object.constantize.new(:product_line => @product_line, :parts => @parts, :makes => @makes, :units => @units)
    
    search_path = search_product_line_parts_path(@product_line.url_friendly)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)
    
    respond_to do |wants|
      wants.html do
        template_file = "parts/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
        render template_file
      end
      
      wants.json do
        parts_template_file = "product_lines/%s/parts.html.erb" % [@product_line.url_friendly.underscore]
        render :json => {
          :dom_id => dom_id(@product_line, :parts),
          :unit_select_options => render_to_string(:partial => 'product_lines/unit_options.html.erb', :locals => { :unit_options => @unit_options }),
          :parts_partial => render_to_string(:partial => parts_template_file, :locals => { :product_line => @product_line, :parts => @parts })
        }
      end
    end
  end
  
  def recent
    @parts = @product_line.parts.recent
    template_file = "parts/index_by_product_line/recent/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def search
    search_term = params[:search][:q]
    @parts = Part.search(params[:search][:q], :with => { :product_line_id => @product_line.id })
    
    @makes = @product_line.associated_makes
    @units = @product_line.associated_units
    
    presenter_object = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = presenter_object.constantize.new(:product_line => @product_line, :parts => @parts, :makes => @makes, :units => @units)
    
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
