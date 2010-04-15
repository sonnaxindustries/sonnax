Factory.define(:publication_title) do |f|
  f.title 'A publication Title'
  f.url_friendly 'a-publication-title'
  f.description 'Here is my description'
  f.volume_number '34'
  f.published_at Time.now
end