class Admin::DistributorsController < Admin::BaseController
  before_filter :authorized?
  before_filter :retrieve_distributor, :only => [:show, :edit, :update, :destroy]
  
  def index
    @distributors = Admin::Distributor.list
  end
  
  def search
    @distributors = Admin::Distributor.search(params[:q], :page => params[:page], :retry_stale => true)
    render :action => :index
  end

  def new
    @distributor = Admin::Distributor.new
  end
  
  def create
    begin
      @distributor = Admin::Distributor.new(params[:distributor])
      @distributor.save!
      flash_and_redirect(admin_distributors_path, 'Distributor has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @distributor.update_attributes!(params[:distributor])
      flash_and_redirect(admin_distributors_path, 'Distributor has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def destroy
    @distributor.destroy
    
    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_distributors_path, 'Distributor has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@distributor)
        }
      end
    end
  end

private
  def retrieve_distributor
    begin
      @distributor = Admin::Distributor.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def authorized?
    true
    #current_user && current_user.edit_distributors?
  end
  
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Distributors', :body_class => 'distributors-home')
  end
end
