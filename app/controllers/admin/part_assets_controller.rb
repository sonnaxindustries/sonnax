class Admin::PartAssetsController < ApplicationController
  before_filter :retrieve_part, :retrieve_part_asset_types
  
  def new
    @part_asset = @part.part_assets.build
  end
  
  def edit
    @part_asset = @part.part_assets.find(params[:id])
  end
  
  def create
    begin
      @part_asset = Admin::PartAsset.new(params[:part_asset])
      @part_asset.save!
      flash_and_redirect(edit_admin_part_path(@part), 'Resource has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
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
