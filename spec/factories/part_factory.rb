Factory.define(:part) do |f|
  f.part_type_id 1
  f.part_number '1234'
  f.oem_part_number '2323'
  f.name 'Part Name'
  f.url_friendly 'part-name'
  f.description 'Here is the part description'
  f.price 99.50
  f.weight 34.34
  f.ref_code '1'
  f.ref_code_sort 3
end