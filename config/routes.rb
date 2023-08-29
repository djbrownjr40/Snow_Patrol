Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  if user_signed_in? && current_user.check_ins&.last.checked_out_at.nil?
    root to: "ski_resorts#show"
  else
    root to: "pages#home"
  end

  resources :ski_resorts, only: [:index, :show] do
    resources :check_ins, only: [:create]
    resources :snow_reports, only: [:create]
  end

  resources :check_ins, only: [:update] do
    resources :reviews, only: [:create]
    # resources :snow_reports, only: [:create]
    # resources :reviews, only: [:create]
  end
end
