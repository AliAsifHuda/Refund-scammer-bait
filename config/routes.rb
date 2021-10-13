Rails.application.routes.draw do


  get 'accounts/new'
  get 'accounts/create'
  get 'new/create'


  ## Resources and routes for admin sessions  and admin user creation##
  resources :admin_users , only: [:new,:create]


  get 'admin', to:'admin_sessions#adminPage'
  get 'admin/login', to: 'admin_sessions#new'
  post 'admin/login',to:'admin_sessions#create'
  get 'admin/logout', to: 'admin_sessions#adminLogout'
  get 'admin/panel' , to: 'admin_sessions#adminPanel'

 ## Resources for user controller with inside the admin pages ##
  resources :user , only: [:new,:create], :path =>'admin/panel/user'
  get 'admin/panel/user/new', :to => 'user1#new', :as => :user
  post 'admin/panel/user/delete', :to => 'user#delete'
  get 'admin/panel/user/:id', to: 'user#show'

## Resources for accounts for user controller inside the admin pages ###
  get '/accounts/new' ,to: 'accounts#new'
  post '/accounts/create', to:'accounts#create'
  get  '/admin/panel/user/:id/:account_id', to:'accounts#admin_view'
  get '/admin/panel/user/:id/:account_id/delete', :to => "accounts#delete"

  # Resources for transactions inside the admin pages
 post '/admin/panel/user/:id/:account_id/create', to:"transactions#create"
 get '/admin/panel/user/:id/:account_id/:transaction_id/delete', to: "transactions#delete"

## resources for managing the main UI ##
  root 'sessions#new'
 
  resources :visitors
  
  get 'visitors/:account_id/transactions', to:'visitors#transactions'
  get 'visitors/:account_id/new_transaction', to:'visitors#new_transaction'
  post 'visitors/:account_id/create_transaction', to:'visitors#create_new_transaction'


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'






  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
