Factory.define(:publication_category) do |f|
  f.parent_id 1
  f.name "value for name"
  f.url_friendly "value-for-name"
  f.description "value for description"
end