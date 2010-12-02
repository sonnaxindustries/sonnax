ActionController::Routing::Routes.draw do |map|  

  map.namespace(:admin) do |admin|
    admin.dashboard '/', :controller => 'base', :action => 'dashboard'
    admin.resources :parts, :member => { :remove_photo => :delete } do |p|
      p.resources :part_assets, :as => 'assets'
    end
    admin.resources :units
    admin.resources :makes
    admin.resources :reference_figures, :as => 'reference-figures', :member => { :remove_avatar => :delete }
    admin.resources :distributors
    admin.resources :publication_titles, :as => 'publications', :member =>  { :remove_pdf => :delete }
    admin.resources :publication_categories, :as => 'publication-categories'
    admin.resources :publication_subjects, :as => 'publication-subjects'
    admin.resources :publication_authors, :as => 'publication-authors'
    admin.resources :users
    admin.resources :unit_components, :as => 'unit-components'

    admin.unit_part_search '/unit/:unit_id/part-search', :controller => 'units', :action => 'search_parts'
    admin.search_single_part '/search-by-part-number', :controller => 'parts', :action => 'quick_search'

    #NOTE: Allison is organized differently, since it is also a Make. Therefore, we want to catch the route and push to it's own controller
    admin.with_options(:controller => 'allison_parts') do |ap|
      ap.connect '/product-lines/4/parts', :action => 'index'
      ap.connect '/product-lines/4/parts/filter', :action => 'filter'
      ap.connect '/product-lines/4/parts/recent', :action => 'recent'
      ap.connect '/product-lines/4/parts/search', :action => 'search'
    end

    admin.resources :product_lines, :as => 'product-lines' do |pl|
      pl.resources :parts, :controller => 'parts_manager', :collection => { :recent => :get, :search => :get, :filter => :get }
    end
    admin.parts_manager '/parts-manager', :controller => 'parts_manager', :action => 'index'
    admin.search_units '/search/units/', :controller => 'units', :action => 'search'
    admin.search_distributors '/search/distributors/', :controller => 'distributors', :action => 'search'
    admin.search_parts '/search/parts', :controller => 'parts', :action => 'search'
    admin.search_reference_figures '/search/reference-figures/', :controller => 'reference_figures', :action => 'search'
    admin.search_publication_titles '/search/publication-titles/', :controller => 'publication_titles', :action => 'search'
  end
  
  map.prototypes_list '/prototypes', :controller => 'prototypes', :action => 'index'
  map.prototype_detail '/prototype/:name', :controller => 'prototypes', :action => 'show'
  map.prototype_validation '/prototype/validation/:part_number', :controller => 'prototypes', :action => 'validation'
  
  map.with_options(:controller => 'pages') do |page|
    page.valve_body_layouts '/valve-body-layouts', :action => 'valve_body_layouts'
    page.insider '/insider', :action => 'insider'
    page.sonnax_insider '/insider', :action => 'insider'
    page.terms_and_conditions '/terms-and-conditions', :action => 'terms_and_conditions'
    page.directions '/directions', :action => 'directions'
    page.history_mission '/history-and-mission', :action => 'history_and_mission'
    page.international_info '/international-info', :action => 'international_info'
    page.tasc_force '/tasc-force', :action => 'tasc_force'
    page.career_opportunities '/career-opportunities', :action => 'career_opportunities'
    page.news_and_events '/news-and-events', :action => 'news_and_events'
    page.warranty '/warranty', :action => 'warranty'
    page.news_and_events '/news-and-events', :action => 'news_and_events'
    page.news_11_10_10 '/news_11_10_10', :action => 'news_11_10_10'
    page.news_5_10_10 '/news_5_10_10', :action => 'news_5_10_10'
    page.news_10_1_10 '/news_10_1_10', :action => 'news_10_1_10'
    page.news_3_8_10 '/news_3_8_10', :action => 'news_3_8_10'
    page.news_2_22_10 '/news_2_22_10', :action => 'news_2_22_10'
    page.news_2_5_10 '/news_2_5_10', :action => 'news_2_5_10'
    page.news_2_5_10 '/news_2_5_10', :action => 'news_2_5_10'
    page.news_2_8_10 '/news_2_8_10', :action => 'news_2_8_10'
    page.news_12_1_09 '/news_12_1_09', :action => 'news_12_1_09'
    page.news_9_1_09 '/news_9_1_09', :action => 'news_9_1_09'
    page.news_archive '/news_archive', :action => 'news_archive'
    page.news_archive '/news_archive', :action => 'news_archive'
    page.events_list '/events', :action => 'events'
    page.international_shipping_and_payment '/international-shipping-and-payment-options', :action => 'international_shipping_and_payment'
    page.harley_distributors '/harley-davidson-distributors', :action => 'harley_distributors'
    page.high_performance_distributors '/high-performance-distributors', :action => 'hp_distributors'
    page.subscribe_to_email_newsletter '/subscribe-to-email-newsletter', :action => 'subscribe_to_email_newsletter' 
    page.about_us '/about-us', :action => 'about_us'
    page.how_to_order '/how-to-order', :action => 'how_to_order'
    page.quick_search '/quick-search', :action => 'quick_search'
    page.technical_information '/technical-information', :action => 'technical_information'
    page.power_train_savers_testimonies '/power-train-savers-testimonies', :action => 'pts_testimonies'
    page.power_train_savers_faq '/power-train-savers-faq', :action => 'pts_faq'
    page.publication_glossary '/publication-glossary', :action => 'publication_glossary'
    page.connect '/page/:template', :action => 'static_page'
  end
  
  map.with_options(:controller => 'speed_orders') do |so|
    so.add_speed_order '/speed-order/add', :action => 'create'
    so.speed_order '/speed-order', :action => 'new'
  end
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resource :contact, :as => 'contact-us'
  map.resource :catalog_request, :as => 'catalog-request', :collection => { :thanks => :get }
  map.register '/register', :controller => 'users', :action => 'new'
  
  map.technical_library '/technical-library', :controller => 'technical_library', :action => 'index'
  map.technical_library_detail '/technical-library/:id', :controller => 'technical_library', :action => 'show'
  map.technical_library_filter '/technical-library/:id/filter', :controller => 'technical_library', :action => 'filter'
  
  map.distributor_by_country '/distributors/by-country/:country_code', :controller => 'distributors', :action => 'filter_by_country'
  map.distributor_by_state '/distributors/by-state/:state_code', :controller => 'distributors', :action => 'filter_by_state'
  map.distributor_by_city '/distributors/by-city/:city_name', :controller => 'distributors', :action => 'filter_by_city'
  
  map.resource :cart, :controller => 'cart',  :member => { :thanks => :get, :add => :post, :empty_cart => :get, :checkout => :post, :add_multiple => :post, :remove => :delete, :update => :put }
  map.resource :solenoid, :as => 'solenoids', :member => 'thanks'
  map.resources :makes
  map.resources :distributors, :collection => { :filter => :get }
  map.resources :reference_figures, :as => 'reference-figures'
  map.resources :units
  map.resources :parts
  
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
    product_line.ring_gears_parts '/ring-gears/parts', :action => 'ring_gears_parts'
    product_line.ring_gears_millimeter_parts '/ring-gears/millimeter-parts', :action => 'ring_gears_millimeter_parts'
    product_line.ring_gears_inches_parts '/ring-gears/inches-parts', :action => 'ring_gears_inches_parts'
    product_line.high_performance_transmission '/high-performance-transmission', :action => 'high_performance_transmission'
    product_line.driveline '/driveline', :action => 'driveline'
    product_line.driveline_parts '/driveline/parts', :action => 'driveline_parts'
    product_line.allison '/allison', :action => 'allison' #NOTE: Move to allison_parts_controller.rb
    product_line.harley_davidson '/harley-davidson', :action => 'harley_davidson'
    product_line.harley_davidson_parts '/harley-davidson/parts', :action => 'harley_davidson_parts'
    product_line.power_train_savers '/power-train-savers', :action => 'power_train_savers'
    product_line.power_train_savers_parts '/power-train-savers/parts', :action => 'power_train_savers_parts'
  end
  
  #NOTE: Allison is organized differently, since it is also a Make. Therefore, we want to catch the route and push to it's own controller
  map.with_options(:controller => 'allison_parts') do |ap|
    ap.connect '/product-lines/allison/parts', :action => 'index'
    ap.connect '/product-lines/allison/parts/filter', :action => 'filter'
    ap.connect '/product-lines/allison/parts/recent', :action => 'recent'
    ap.connect '/product-lines/allison/parts/search', :action => 'search'
  end
  
  map.resources :product_lines, :as => 'product-lines' do |pl|
    pl.resources :parts, :collection => { :recent => :get, :search => :get, :filter => :get }
  end
  
  map.search_single_part '/search-by-part-number', :controller => 'parts', :action => 'quick_search'
#  map.search_single_part '/search-by-part-number', :controller => 'parts', :action => 'search_single'
  
  map.with_options(:controller => 'user_sessions') do |us|
    us.login '/login', :action => 'new'
    us.sign_in '/sign-in', :action => 'new'
    us.sign_out '/sign-out', :action => 'destroy'
  end
  
  map.root :controller => 'pages', :action => 'home'
  
  map.connect '/part_finder.php', :controller => 'part_finder', :action => 'redirect'
  map.connect '/part_summary.php', :controller => 'part_finder', :action => 'part_summary_redirect'
  #map.connect '*path' , :controller => 'redirects' , :action => 'check'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
