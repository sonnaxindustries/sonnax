ActionController::Routing::Routes.draw do |map|  
  map.namespace(:admin) do |admin|
    admin.resources :product_lines, :as => 'product-lines'
    admin.resources :parts
    admin.resources :units
    admin.resources :makes
    admin.resources :reference_figures, :as => 'reference-figures'
    admin.resources :distributors
    admin.resources :publication_titles, :as => 'publications'
    admin.resources :publication_categories, :as => 'publication-categories'
    admin.resources :users
  end
  
  map.prototypes_list '/prototypes', :controller => 'prototypes', :action => 'index'
  map.prototype_detail '/prototype/:name', :controller => 'prototypes', :action => 'show'
  map.prototype_validation '/prototype/validation/:part_number', :controller => 'prototypes', :action => 'validation'
  
  map.with_options(:controller => 'pages') do |page|
    page.history_mission '/history-and-mission', :action => 'history_and_mission'
    page.international_info '/international-info', :action => 'international_info'
    page.tasc_force '/tasc-force', :action => 'tasc_force'
    page.career_opportunities '/career-opportunities', :action => 'career_opportunities'
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
  end
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resource :contact, :as => 'contact-us'
  map.register '/register', :controller => 'users', :action => 'new'
  
  map.resources :makes
  map.resources :distributors
  map.resources :publication_categories, :as => 'publications' do |ppub|
    ppub.resources :publication_subcategories, :as => 'subcategories' do |scat|
      scat.resources :publication_titles, :as => 'titles'
    end
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