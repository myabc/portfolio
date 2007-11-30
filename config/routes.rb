ActionController::Routing::Routes.draw do |map|
  
  map.resources :clients
  map.resources :projects
  map.resources :media
  map.resources :users
  map.resources :roles
  map.resource :session
  
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login' , :controller => 'session', :action => 'new'
  map.logout '/logout', :controller => 'session', :action => 'destroy'
  
  map.connect ':controller/:action/:id' 

  map.connect '', :controller => 'projects'
end
