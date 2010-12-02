class Admin::PartsController < Admin::BaseController
  before_filter :retrieve_part, :only => [:edit, :update, :destroy]
  before_filter :retrieve_product_line_options, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :retrieve_part_type_options, :only => [:new, :create, :edit, :update, :destroy]
  
  def index
    @parts = Admin::Part.list(params)
  end
  
  def search
    @parts = Admin::Part.search(params[:q], :page => params[:page])
    render :action => :index
  end

  def new
    @part = Admin::Part.new
  end

  def quick_search
    begin
      @unit = Unit.find_by_id!(params[:search][:unit_id])
      @parts = Part.search_by_filter!(params[:search][:q])
      @search_form_presenter = SearchFormPresenter.new(:unit_id => params[:search][:unit_id], :search_terms => params[:search][:q], :url => admin_search_single_part_path)

      respond_to do |wants|
        wants.html do
          render :action => :quick_search
        end
      end
    rescue Part::NoSearchResults 
      @search_form_presenter = SearchFormPresenter.new(:unit_id => params[:search][:unit_id], :search_terms => params[:search][:q], :url => admin_search_single_part_path)
      render :template => 'admin/parts/no_search_results.html.erb'
    end
  end

  def create
    begin
      @part = Admin::Part.new(params[:part])
      @part.save!
      flash_and_redirect(admin_parts_path, 'Part has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @part.update_attributes!(params[:part])
      flash_and_redirect(admin_parts_path, 'Part has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def destroy
    @part.destroy
    
    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_parts_path, 'Part has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@part)
        }
      end
    end
  end
  
private
  def retrieve_part
    begin
      @part = Admin::Part.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def retrieve_product_line_options
    @product_line_options = Admin::ProductLine.options
  end
  
  def retrieve_part_type_options
    @part_type_options = Admin::PartType.options
  end
  
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Parts', :body_class => 'parts-home')
  end
end
