ActionController::Routing::Routes.draw do |map|  
  map.namespace(:admin) do |admin|
    admin.dashboard '/', :controller => 'base', :action => 'dashboard'
    admin.resources :product_lines, :as => 'product-lines'
    admin.resources :parts
    admin.resources :units
    admin.resources :makes
    admin.resources :reference_figures, :as => 'reference-figures', :member => { :remove_avatar => :delete }
    admin.resources :distributors
    admin.resources :publication_titles, :as => 'publications', :member =>  { :remove_pdf => :delete }
    admin.resources :publication_categories, :as => 'publication-categories'
    admin.resources :users
    
    admin.search_units '/search/units/', :controller => 'units', :action => 'search'
    admin.search_distributors '/search/distributors/', :controller => 'distributors', :action => 'search'
    admin.search_reference_figures '/search/reference-figures/', :controller => 'reference_figures', :action => 'search'
    admin.search_publication_titles '/search/publication-titles/', :controller => 'publication_titles', :action => 'search'
  end
  
  map.prototypes_list '/prototypes', :controller => 'prototypes', :action => 'index'
  map.prototype_detail '/prototype/:name', :controller => 'prototypes', :action => 'show'
  map.prototype_validation '/prototype/validation/:part_number', :controller => 'prototypes', :action => 'validation'
  
  map.with_options(:controller => 'pages') do |page|
    page.valve_body_layouts '/valve-body-layouts', :action => 'valve_body_layouts'
    page.insider '/insider', :action => 'insider'
    page.terms_and_conditions '/terms-and-conditions', :action => 'terms_and_conditions'
    page.directions '/directions', :action => 'directions'
    page.history_mission '/history-and-mission', :action => 'history_and_mission'
    page.international_info '/international-info', :action => 'international_info'
    page.tasc_force '/tasc-force', :action => 'tasc_force'
    page.career_opportunities '/career-opportunities', :action => 'career_opportunities'
    page.news_and_events '/news-and-events', :action => 'news_and_events'
    page.news_list '/news', :action => 'news'
    page.events_list '/events', :action => 'events'
    page.international_shipping_and_payment '/international-shipping-and-payment-options', :action => 'international_shipping_and_payment'
    page.sonnax_insider '/sonnax-insider', :action => 'sonnax_insider'
    page.catalog_request '/catalog-request', :action => 'catalog_request'
    page.harley_distributors '/harley-davidson-distributors', :action => 'harley_distributors'
    page.subscribe_to_email_newsletter '/subscribe-to-email-newsletter', :action => 'subscribe_to_email_newsletter' 
    page.about_us '/about-us', :action => 'about_us'
    page.how_to_order '/how-to-order', :action => 'how_to_order'
    page.quick_search '/quick-search', :action => 'quick_search'
    page.technical_information '/technical-information', :action => 'technical_information'
    page.power_train_savers_testimonies '/power-train-savers-testimonies', :action => 'pts_testimonies'
    page.power_train_savers_faq '/power-train-savers-faq', :action => 'pts_faq'
    page.connect '/page/:template', :action => 'static_page'
  end
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resource :contact, :as => 'contact-us'
  map.register '/register', :controller => 'users', :action => 'new'
  
  map.technical_library '/technical-library', :controller => 'technical_library', :action => 'index'
  map.technical_library_detail '/technical-library/:id', :controller => 'technical_library', :action => 'show'
  map.technical_library_filter '/technical-library/:id/filter', :controller => 'technical_library', :action => 'filter'
  
  map.distributor_by_country '/distributors/by-country/:country_code', :controller => 'distributors', :action => 'filter_by_country'
  map.distributor_by_state '/distributors/by-state/:state_code', :controller => 'distributors', :action => 'filter_by_state'
  map.distributor_by_city '/distributors/by-city/:city_name', :controller => 'distributors', :action => 'filter_by_city'
  
  map.resource :solenoid, :as => 'solenoids', :member => 'thanks'
  map.resources :makes
  map.resources :distributors
  map.resources :reference_figures, :as => 'reference-figures'
  map.resources :units
  
  map.resources :publication_keywords, :as => 'keywords'
  map.resources :publication_authors, :as => 'authors'
  map.resources :publication_titles, :as => 'titles'
  map.resources :publication_subjects, :as => 'publication-subjects'
  map.resources :publication_types, :as => 'publication-types'
  map.resources :publication_categories, :as => 'publications' do |ppub|
    ppub.resources :publication_titles, :as => 'titles'
    ppub.resources :publication_subcategories, :as => 'subcategories' do |scat|
      scat.resources :publication_titles, :as => 'titles'
    end
  end
  
  map.with_options(:controller => 'product_lines', :path_prefix => '/product-lines') do |product_line|
    product_line.transmission '/transmission', :action => 'transmission'
    product_line.torque_converter '/torque-converter', :action => 'torque_converter'
    product_line.ring_gears '/ring-gears', :action => 'ring_gears'
    product_line.high_performance_transmission '/high-performance-transmission', :action => 'high_performance_transmission'
    product_line.driveline '/driveline', :action => 'driveline'
    product_line.allison '/allison', :action => 'allison'
    product_line.harley_davidson '/harley-davidson', :action => 'harley_davidson'
    product_line.harley_davidson_parts '/harley-davidson/parts', :action => 'harley_davidson_parts'
    product_line.power_train_savers '/power-train-savers', :action => 'power_train_savers'
  end
  
  map.resources :product_lines, :as => 'product-lines' do |pl|
    pl.resources :parts, :collection => { :recent => :get }
  end
  
  map.with_options(:controller => 'user_sessions') do |us|
    us.login '/login', :action => 'new'
    us.sign_in '/sign-in', :action => 'new'
    us.sign_out '/sign-out', :action => 'destroy'
  end
  
  map.root :controller => 'pages', :action => 'home'
  
  #map.connect '*path' , :controller => 'redirects' , :action => 'check'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end