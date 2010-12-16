class AllisonPartsController < ApplicationController
  before_filter :retrieve_product_line, :except => [:search_single]
  
  def index
    @parts = []
    @units = @product_line.units  
    @makes = @product_line.associated_makes

    form_presenter = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = form_presenter.constantize.new(:product_line => @product_line, :parts => @parts, :makes => @makes, :units => @units)
    
    search_path = search_product_line_parts_path(@product_line.url_friendly)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)
    
    template_file = "parts/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def filter
    @makes = []
    @units = @product_line.units
    @make = Make.allison
    @parts = []
    @make = nil
    @unit = nil

    params[:filter].reverse_merge!(:product_line => @product_line) if params[:filter]
    params[:filter].reverse_merge!(:make => Make.find_by_url_friendly('allison')) if params[:filter]
    
    form_presenter = "ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    collection_presenter = "ProductLine::%s::CollectionPresenter" % [@product_line.url_friendly.underscore.classify]
    
    @form_presenter = form_presenter.constantize.new(:product_line => @product_line, :parts => @parts, :makes => @makes, :units => @units, :make => @make, :unit => @unit)
    @collection_presenter = collection_presenter.constantize.new(:product_line => @product_line, :parts => @parts, :make => @make, :unit => @unit)

    if params[:filter] && !params[:filter][:unit].blank?    
      @make = Make.allison
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
        render :json => {
          :redirect_url => @collection_presenter.redirect_url
         # :dom_id => dom_id(@product_line, :parts),
         # :unit_select_options => render_to_string(:partial => 'product_lines/unit_options.html.erb', :locals => { :unit_options => @form_presenter.unit_options }),
         # :parts_partial => render_to_string(:partial => parts_template_file, :locals => { :product_line => @product_line, :parts => @parts })
        }
      end
    end
  end
  
  def search
    @makes = []
    @units = @product_line.units
    @make = Make.allison
    @parts = []
    @make = nil
    @unit = nil
    
    search_term = if params[:search] && !params[:search][:q].blank?
      params[:search][:q]
    elsif params[:q]
      params[:q]
    end
    
    @parts = Part.search_by_filter(search_term, :product_line => @product_line)
    
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
  
  def recent
    @parts = @product_line.parts.recent
    template_file = "parts/index_by_product_line/recent/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end

private
  def retrieve_product_line
    begin
      @product_line = ProductLine.detail!('allison')
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
