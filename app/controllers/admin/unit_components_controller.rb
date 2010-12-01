class Admin::UnitComponentsController < Admin::BaseController
  before_filter :retrieve_unit_component, :only => [:edit, :update, :destroy]

  def destroy
    @unit_component.destroy

    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_product_lines_path, 'Part removed from Unit')
      end

      wants.json do
        render :json => {
          :id_to_remove => dom_id(@unit_component)
        }
      end
    end
  end
private
  def retrieve_unit_component
    begin
      @unit_component = Admin::UnitComponent.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
