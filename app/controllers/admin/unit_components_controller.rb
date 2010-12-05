class Admin::UnitComponentsController < Admin::BaseController
  before_filter :retrieve_unit_component, :only => [:edit, :update, :destroy]

  def edit
    
  end

  def update
    begin
      @unit_component.update_attributes!(params[:unit_component])
      flash_and_redirect(admin_product_lines_path, 'Unit Component has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end

  def quick_create
    begin
      @unit_component = Admin::UnitComponent.new(params[:unit_component])
      @unit_component.save!
      unit = Unit.find(params[:unit_component][:unit_id])
      part = Part.find(params[:unit_component][:part_id])
      redirect_path = filter_admin_product_line_parts_path(unit.product_line.id, :"filter[make]" => part.make.id, :"filter[unit]" => unit.id)
      flash_and_redirect(redirect_path, 'Part has been added')
    rescue ActiveRecord::RecordInvalid
      render_404
    end
  end

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
