Rails.application.routes.draw do
  
  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices
  resources :users
  resources :sessions
  resources :orders
  resources :schools
  resources :carts

  # resources :carts do
  #   post :add, on: :collection
  # end

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'view_employees' => 'users#view_employees', :as => :view_employee_index
  get 'view_customers' => 'users#view_customers', :as => :view_customer_index
  get 'add_item/:id' => 'carts#add_item', :as => :add_item
  get 'remove_item/:id' => 'carts#remove_item', :as => :remove_item
  get 'checkout' => 'carts#checkout', :as => :checkout
  patch 'complete_order_item/:id' => 'order_items#complete_order_item', :as => :complete_order_item
  get 'my_orders' => 'orders#my_orders', :as => :my_orders
  get 'view_order/:id' => 'orders#view_order', :as => :view_order
  # Set the root url
  root :to => 'home#home'  

end
