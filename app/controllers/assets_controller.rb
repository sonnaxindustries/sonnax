class AssetsController < ApplicationController
  def show
    begin
      full_filename = "%s.%s" % [params[:filename], params[:format]]
      record = Asset.find_by_asset_file_name!(full_filename)
      streaming_options = {
        :filename => record.asset_file_name,
        :type => record.asset_content_type,
        :status => 200,
        :disposition => 'inline'
      }
      send_data(record.asset.path)
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
