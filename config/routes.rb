Rails.application.routes.draw do
  get 'welcome/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  root "welcome#index"
  
  resources :posts, only: [:new, :create, :index , :destroy, :show] do
    member do
      post 'like'
      post 'dislike'
    end
  end
  resources :posts do
    resources :comments, only: [:create]
  end
end