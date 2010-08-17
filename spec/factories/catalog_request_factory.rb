Factory.define(:catalog_request) do |f|
  f.name 'Testing'
  f.company 'Here is my company'
  f.type_of_business 'Here is my type of business'
  f.address '111 main street'
  f.city 'Panama City'
  f.state 'Florida'
  f.postal_code 12345
  f.country 'US'
  f.phone_number '123-232-2323'
  f.email_address 'testing@example.com'
end