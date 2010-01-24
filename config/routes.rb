ActionController::Routing::Routes.draw do |map|
  map.namespace(:admin) do |admin|
  end
  
  map.root :controller => 'application', :action => 'home'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end