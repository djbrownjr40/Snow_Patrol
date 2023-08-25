Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "pages#home"

  resources :ski_resorts, only: [:index, :show] do
    resources :check_ins, only: [:create]
    resources :snow_reports, only: [:create]
    resources :reviews, only: [:new, :create]
  end

  resources :check_ins, only: [:update] do
    # resources :snow_reports, only: [:create]
    # resources :reviews, only: [:create]
  end
end
