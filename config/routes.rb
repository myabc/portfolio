ActionController::Routing::Routes.draw do |map|
  
  map.resources :clients
  map.resources :projects
  map.resources :media
  map.resources :users
  map.resources :roles
  map.resources :sessions

  map.contact '/contact', :controller => 'contact'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login' , :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.connect ':controller/:action/:id' 

  map.connect '', :controller => 'projects'
end
