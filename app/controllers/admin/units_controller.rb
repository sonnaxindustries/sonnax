class Admin::UnitsController < Admin::BaseController
  before_filter :retrieve_unit, :only => [:show, :edit, :update, :destroy]
  before_filter :retrieve_product_line_options, :only => [:edit, :update, :new, :create]
  
  def index
    @units = Admin::Unit.list(params)
  end
  
  def search
    @units = Admin::Unit.search(params[:q], :page => params[:page])
    render :action => :index
  end

  def new
    @unit = Admin::Unit.new
  end

  def edit
  end
  
  def create
    begin
      @unit = Admin::Unit.new(params[:unit])
      @unit.save!
      flash_and_redirect(admin_units_path, 'Unit has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @unit.update_attributes!(params[:unit])
      flash_and_redirect(admin_units_path, 'Unit has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def destroy
    @unit.destroy
    
    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_units_path, 'Unit has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@unit)
        }
      end
    end
  end
  
private 
  def retrieve_unit
    begin
      @unit = Admin::Unit.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def retrieve_product_line_options
    @product_line_options = Admin::ProductLine.options
  end
end