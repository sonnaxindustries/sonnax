class Admin::ReferenceFiguresController < Admin::BaseController
  before_filter :retrieve_reference_figure, :only => [:edit, :update, :destroy, :remove_avatar]
  
  def index
    @reference_figures = Admin::ReferenceFigure.list(params)
  end
  
  def search
    @reference_figures = Admin::ReferenceFigure.search(params[:q], :page => params[:page])
    render :action => :index
  end

  def new
    @reference_figure = Admin::ReferenceFigure.new
  end

  def edit
  end
  
  def create
    begin
      @reference_figure = Admin::ReferenceFigure.new(params[:reference_figure])
      @reference_figure.save!
      flash_and_redirect(admin_reference_figures_path, 'Reference figure has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @reference_figure.update_attributes!(params[:reference_figure])
      flash_and_redirect(admin_reference_figures_path, 'Reference figure has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def remove_avatar
    @reference_figure.remove_avatar!
    
    respond_to do |wants|
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@reference_figure, :avatar)
        }
      end
    end
  end
  
  def destroy
    @reference_figure.destroy
    
    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_reference_figures_path, 'Reference figure has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@reference_figure),
          :message => 'Reference figure has been removed'
        }
      end
    end
  end
  
private
  def retrieve_reference_figure
    begin
      @reference_figure = Admin::ReferenceFigure.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end