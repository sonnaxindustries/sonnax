class Admin::PartAssetsController < Admin::BaseController
  before_filter :retrieve_part, :retrieve_part_asset_types
  
  def new
    @part_asset = @part.part_assets.build
  end
  
  def edit
    @part_asset = @part.part_assets.find(params[:id])
  end
  
  def create
    begin
      params[:part_asset].reverse_merge!(:part_id => params[:part_id])
      @part_asset = Admin::PartAsset.new(params[:part_asset])
      @part_asset.save!
      flash_and_redirect(edit_admin_part_path(@part), 'Resource has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end

  def update
    begin
      params[:part_asset].reverse_merge!(:part_id => params[:part_id])
      @part_asset = @part.part_assets.find(params[:id])
      @part_asset.update_attributes!(params[:part_asset])
      flash_and_redirect(edit_admin_part_path(@part), 'Resource has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end

  def destroy
    @part_asset = @part.part_assets.find(params[:id])
    @part_asset.destroy


    respond_to do |wants|
      wants.html do
        flash_and_redirect(edit_admin_part_path(@part), 'Attachment has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@part_asset)
        }
      end
    end
  end

private
  def retrieve_part
    begin
      @part = Admin::Part.detail!(params[:part_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def retrieve_part_asset_types
    @part_asset_types = Admin::PartAssetType.options
  end
end
