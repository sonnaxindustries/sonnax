ActionController::Routing::Routes.draw do |map|  
  map.namespace(:admin) do |admin|
    admin.resources :distributors
    admin.resources :makes
  end
  
  map.prototypes_list '/prototypes', :controller => 'prototypes', :action => 'index'
  map.prototype_detail '/prototype/:name', :controller => 'prototypes', :action => 'show'
  map.prototype_validation '/prototype/validation/:part_number', :controller => 'prototypes', :action => 'validation'
  
  map.with_options(:controller => 'pages') do |page|
    page.history_mission '/history-and-mission', :action => 'history_and_mission'
    page.international_info '/international-info', :action => 'international_info'
    page.international_shipping_and_payment '/international-shipping-and-payment-options', :action => 'international_shipping_and_payment'
    page.sonnax_insider '/sonnax-insider', :action => 'sonnax_insider'
    page.request_catalogs '/request-catalogs', :action => 'request_catalogs'
  end
  
  map.resources :makes
  map.resource :user_session
  map.resource :account, :controller => "users"
  
  map.resources :distributors
  map.resources :publication_categories, :as => 'publications' do |ppub|
    ppub.resources :publication_subcategories, :as => 'subcategories' do |scat|
      scat.resources :publication_titles, :as => 'titles'
    end
  end
  
  map.with_options(:controller => 'user_sessions') do |us|
    us.login '/login', :action => 'new'
    us.logout '/logout', :action => 'destroy'
  end
  
  map.register '/register', :controller => 'users', :action => 'new'
  
  map.root :controller => 'pages', :action => 'home'
  
  #map.connect '*path' , :controller => 'redirects' , :action => 'check'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end