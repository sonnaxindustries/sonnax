class PartsController < ApplicationController
  before_filter :retrieve_product_line, :except => [:search_single]
  
  def index
    @parts = []
    @units = []    
    @makes = @product_line.associated_makes

    form_presenter = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = form_presenter.constantize.new(:product_line => @product_line, :parts => @parts, :makes => @makes, :units => @units)
    
    search_path = search_product_line_parts_path(@product_line.url_friendly)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)
    
    template_file = "parts/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def filter    
    @makes = @product_line.associated_makes
    @units = []
    @parts = []
    @make, @unit = nil

    params[:filter].reverse_merge!(:product_line => @product_line) if params[:filter]
    
    @form_presenter = @product_line.new_form_presenter(:parts => @parts, :makes => @makes, :units => @units, :make => @make, :unit => @unit)
    @collection_presenter = @product_line.new_collection_presenter(:parts => @parts, :make => @make, :unit => @unit)

    if params[:filter] && !params[:filter][:make].blank? && params[:filter][:unit].blank?
      @make = Make.find(params[:filter][:make])
      @parts = []
      
      @form_presenter = @product_line.new_form_presenter(:parts => @parts, :makes => @makes, :units => @units, :make => @make, :unit => @unit)
      @collection_presenter = @product_line.new_collection_presenter(:parts => @parts, :make => @make, :unit => @unit)
    end
    
    if params[:filter] && !params[:filter][:make].blank? && !params[:filter][:unit].blank?
      @make = Make.find(params[:filter][:make])
      @unit = Unit.find(params[:filter][:unit])  
      @parts = @product_line.parts_by_filter(params[:filter] || {})
      
      @form_presenter = @product_line.new_form_presenter(:parts => @parts, :makes => @makes, :units => @units, :make => @make, :unit => @unit)
      @collection_presenter = @product_line.new_collection_presenter(:parts => @parts, :make => @make, :unit => @unit)
    end
        
    search_path = search_product_line_parts_path(@product_line.url_friendly)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)
    
    respond_to do |wants|
      wants.html do
        template_file = "parts/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
        render template_file
      end
      
      wants.json do
        parts_template_file = "product_lines/%s/parts.html.erb" % [@product_line.url_friendly.underscore]
        no_parts_template_file = "product_lines/%s/no_parts.html.erb" % [@product_line.url_friendly.underscore]
        render :json => {
          :dom_id => dom_id(@product_line, :parts),
          :unit_select_options => render_to_string(:partial => 'product_lines/unit_options.html.erb', :locals => { :unit_options => @form_presenter.unit_options }),
          :no_parts_partial => render_to_string(:partial => no_parts_template_file, :locals => { :product_line => @product_line }),
          :parts_partial => render_to_string(:partial => parts_template_file, :locals => { :product_line => @product_line, :parts => @parts })
        }
      end
    end
  end
  
  def recent
    @parts = @product_line.recent_parts
    
    template_file = "parts/index_by_product_line/recent/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def search

    search_term = if params[:search] && !params[:search][:q].blank?
      params[:search][:q]
    elsif params[:q]
      params[:q]
    end
    
    @parts = @product_line.search_parts(search_term)
    
    @makes = @product_line.associated_makes
    @units = @product_line.associated_units
    
    @form_presenter = @product_line.new_form_presenter(:parts => @parts, :makes => @makes, :units => @units)
    
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
  
  def search_single
    begin
      @part = Part.find_single!(params[:search][:q])
      
      respond_to do |wants|
        wants.html do
          render :action => :show
        end
      end
    rescue ActiveRecord::RecordNotFound
      @search_form_presenter = SearchFormPresenter.new(:search_terms => params[:search][:q], :url => search_single_part_path)
      render :template => 'parts/no_search_results.html.erb'
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
