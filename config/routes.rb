Rails.application.routes.draw do
  
  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices
  resources :users
  resources :sessions
  resources :orders
  resources :schools

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

  # Set the root url
  root :to => 'home#home'  

end
