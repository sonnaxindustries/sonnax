Factory.define(:asset) do |f|
  f.asset_file_name "filename.pdf"
  f.asset_file_size 1
  f.asset_content_type "application/pdf"
  f.asset_updated_at Time.now
end