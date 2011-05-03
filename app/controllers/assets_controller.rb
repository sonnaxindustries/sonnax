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

  def reverse_show
    found = false
    full_filename = "%s.%s" % [params[:filename], params[:format]]

    dirs = [
      "#{Rails.root}/public/system/announcement",
      "#{Rails.root}/public/system/instructions",
      "#{Rails.root}/public/system/part-images",
      "#{Rails.root}/public/system/tech",
      "#{Rails.root}/public/system/vbfix"
    ]

    dirs.each do |d|
      full_path = "%s/%s" % [d, full_filename]

      if File.exists?(full_path)
        found = true
        system_path = d.split('/')[-2,2].join('/')
        @url_redirect_path = "http://www.sonnax.com/%s/%s" % [system_path, full_filename]
      else
        found = false
      end
    end

    if found
      redirect_to(@url_redirect_path, :code => 301) and return
    else
      render_404
    end
  end
end
