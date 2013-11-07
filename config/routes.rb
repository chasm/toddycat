ToddyCat::Application.routes.draw do
  
  scope :api do
    resources :users, except: [ :new, :edit ], default: { format: :json }
  end
  
  # Sign in/out
  get    'login'  => 'session#new',     as: :login
  post   'login'  => 'session#create'
  delete 'logout' => 'session#destroy', as: :logout
  get    'logout' => 'session#destroy'  # temporary for development
  
  # Registration
  get  'register/:code' => 'registration#new', as: :register
  post 'register/:code' => 'registration#create'
  
  # Password reset
  get   'reset/:code' => 'password#edit', as: :reset
  put   'reset/:code' => 'password#update'
  patch 'reset/:code' => 'password#update'
  
  get 'privacy' => 'site#privacy'
  get 'terms'   => 'site#terms'
  
  root 'site#index'
end
