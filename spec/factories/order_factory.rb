Factory.define(:order) do |f|
  f.name 'John Doe'
  f.company 'ABC Widgets'
  f.postal_code '334232'
  f.email 'john@abcwidgets.com'
  f.po_number 33534
  f.shipping_method 'UPS Ground'
  f.comments 'No comment'
end