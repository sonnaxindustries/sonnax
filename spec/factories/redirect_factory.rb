Factory.define(:redirect) do |f|
  f.old_url '/testing'
  f.new_url '/new-place'
  f.http_code 301
end