ActionController::Routing::Routes.draw do |map|
  map.namespace(:admin) do |admin|
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