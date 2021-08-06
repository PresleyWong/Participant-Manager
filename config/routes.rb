Rails.application.routes.draw do
  resources :events
  resources :participants
  devise_for :servers
  devise_for :admins

  root to: "home#index"
  post '/register/:event_id/:participant_id', to: 'events#register_participant', as: :register_participant
  get '/remove_participant/:event_id/:participant_id', to: 'events#remove_participant', as: :remove_participant
  get '/export/:event_id', to: 'participants#export', as: :export_participant
  post '/import/:event_id', to: 'participants#import', as: :import_participant












  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
