ActionController::Routing::Routes.draw do |map|

  map.resources :projects
  map.root :controller => "welcome"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect "*anything", :controller => "page", :action => "show"

end
