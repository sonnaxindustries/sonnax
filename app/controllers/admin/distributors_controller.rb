class Admin::DistributorsController < Admin::BaseController
  before_filter :retrieve_distributor, :only => [:show, :edit, :update, :destroy]
  
  def index
    @distributors = Admin::Distributor.all
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
    flash_and_redirect(admin_distributors_path, 'Distributor has been removed')
  end

private
  def retrieve_distributor
    begin
      @distributor = Admin::Distributor.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end