Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope '/:locale' do
    resources :sessions, only: %i[new create]
    resources :registrations, only: %i[new show create]

    get '/home', to: 'pages#home'
    get '/destroy_sessions', to: 'sessions#destroy'
  end

  root 'pages#home'
end
