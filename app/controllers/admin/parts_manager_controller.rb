class Admin::PartsManagerController < Admin::BaseController
  before_filter :retrieve_product_line, :except => [:search_single, :quick_search]
  
  def index
    @parts = []
    @units = []    
    @makes = @product_line.associated_makes

    form_presenter = "Admin::ProductLine::%s::FormPresenter" % [@product_line.url_friendly.underscore.classify]
    @form_presenter = form_presenter.constantize.new(:product_line => @product_line, :parts => @parts, :makes => @makes, :units => @units)
    
    search_path = search_admin_product_line_parts_path(@product_line.id)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)
    
    template_file = "admin/parts_manager/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def filter    
    @makes = @product_line.associated_makes
    @units = []
    @parts = []
    @make = nil
    @unit = nil

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

    search_path = search_admin_product_line_parts_path(@product_line.id)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => '', :url => search_path)

    respond_to do |wants|
      wants.html do
        template_file = "admin/parts_manager/index_by_product_line/%s" % [@product_line.url_friendly.underscore]
        render template_file
      end
      
      wants.json do
        parts_template_file = "admin/product_lines/%s/parts.html.erb" % [@product_line.url_friendly.underscore]
        no_parts_template_file = "admin/product_lines/%s/no_parts.html.erb" % [@product_line.url_friendly.underscore]
        render :json => {
          :redirect_url => @collection_presenter.redirect_url
        }
      end
    end
  end
  
  def recent
    @parts = @product_line.recent_parts
    
    template_file = "admin/parts_manager/index_by_product_line/recent/%s" % [@product_line.url_friendly.underscore]
    render template_file
  end
  
  def search

    search_term = if params[:search] && !params[:search][:q].blank?
      params[:search][:q].strip
    elsif params[:q]
      params[:q].strip
    end
    
    @parts = @product_line.search_parts(search_term)
    
    @makes = @product_line.associated_makes
    @units = @product_line.associated_units
    
    @form_presenter = @product_line.new_form_presenter(:parts => @parts, :makes => @makes, :units => @units)
    
    search_path = search_admin_product_line_parts_path(@product_line.id)
    @search_form_presenter = SearchFormPresenter.new(:search_terms => search_term, :url => search_path)
    
    template_file = "admin/parts_manager/index_by_product_line/search/%s" % [@product_line.url_friendly.underscore]
    
    respond_to do |wants|
      wants.html do
        render template_file
      end
      wants.json do
      end
    end
  end
  
  def quick_search
    begin
      @parts = Part.search_by_filter!(params[:search][:q])
      @search_form_presenter = SearchFormPresenter.new(:search_terms => params[:search][:q], :url => search_single_part_path)

      respond_to do |wants|
        wants.html do
          render :action => :quick_search
        end
      end
    rescue Part::NoSearchResults 
      @search_form_presenter = SearchFormPresenter.new(:search_terms => params[:search][:q], :url => search_single_part_path)
      render :template => 'admin/parts_manager/no_search_results.html.erb'
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
      render :template => 'admin/parts_manager/no_search_results.html.erb'
    end
  end

  def show
    begin
      @part = @product_line.parts.find(params[:id])
      template_file = "admin/parts_manager/show_by_product_line/%s" % [@product_line.url_friendly.underscore]
      render template_file
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
private
  def retrieve_product_line
    begin
      product_line = ProductLine.find_by_id!(params[:product_line_id])
      product_line_ns = "Admin::%s" % [product_line.type.to_s]
      @product_line = product_line_ns.constantize.find(params[:product_line_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  def redirect_url(product_line, make, unit)
    if !make.blank? && unit.blank?
      filter_admin_product_line_parts_path(product_line.id, :"filter[make]" => make)
    elsif !make.blank? && !unit.blank?
      filter_admin_product_line_parts_path(product_line.id, :"filter[make]" => make, :"filter[unit]" => unit)
    end
  end
end
