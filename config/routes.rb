PartyPlanner::Application.routes.draw do
  match 'host/edit' => 'hosts#edit', :as => :edit_current_host

  match 'signup' => 'hosts#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  match 'home' => 'home#index', :as => :home
  
  match 'about' => 'home#about', :as => :about
  
  match 'contact' => 'home#contact', :as => :contact
  
  match 'privacy' => 'home#privacy', :as => :privacy
  
  match 'rsvp' => 'invitations#start_rsvp', :as => :start_rsvp
  
  match 'rsvp_form' => 'invitations#rsvp_form', :as => :rsvp_form
  
  match 'forgot_password' => 'hosts#forgot_password', :as => :forgot_password
  
  match 'account_info' => 'hosts#account_info', :as => :account_info
  
  #match 'details' => 'home#rsvp_form', :as => _rsvp_form
  
  resources :sessions

  resources :hosts

  resources :party_types

  resources :parties

  resources :locations

  resources :invitations

  resources :gifts

  resources :guests
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
