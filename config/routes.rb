ActionController::Routing::Routes.draw do |map|
  map.namespace(:admin) do |admin|
  end
  
  map.with_options(:controller => 'pages') do |page|
    page.history_mission '/history-and-mission', :action => 'history_and_mission'
    page.international_info '/international-info', :action => 'international_info'
    page.international_shipping_and_payment '/international-shipping-and-payment-options', :action => 'international_shipping_and_payment'
  end
  
  map.resource :users
  map.resource :user_session
  map.resource :account, :controller => "users"
  
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.register '/register', :controller => 'users', :action => 'new'
  
  map.root :controller => 'application', :action => 'home'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end