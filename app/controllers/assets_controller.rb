class AssetsController < ApplicationController
  def show
    begin
      full_filename = "%s.%s" % [params[:filename], params[:format]]
      record = Asset.find_by_asset_file_name!(full_filename)
      redirect_to(record.asset.url, :host => 'http://www.sonnax.com', :code => 301)
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
