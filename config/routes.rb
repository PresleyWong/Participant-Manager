Rails.application.routes.draw do
  resources :events
  resources :participants
  devise_for :servers
  devise_for :admins

  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
