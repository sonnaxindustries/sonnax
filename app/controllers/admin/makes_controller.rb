class Admin::MakesController < Admin::BaseController
  before_filter :retrieve_make, :only => [:edit, :update, :destroy]
  
  def index
    @makes = Admin::Make.list
  end

  def new
    @make = Admin::Make.new
  end

  def edit
  end
  
  def create
    begin
      @make = Admin::Make.new(params[:make])
      @make.save!
      flash_and_redirect(admin_makes_path, 'Make has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @make.update_attributes!(params[:make])
      flash_and_redirect(admin_makes_path, 'Make has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def destroy
    @make.destroy
    
    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_makes_path, 'Make has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@make)
        }
      end
    end
  end

private
  def retrieve_make
    begin
      @make = Admin::Make.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end