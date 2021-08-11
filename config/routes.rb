Rails.application.routes.draw do

  devise_for :servers, path: 'servers', controllers: {
    sessions: 'servers/sessions',
    registrations: 'servers/registrations'
  }

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  devise_scope :server do
    authenticated :server do
      namespace :servers do
        get 'dashboard/index', as: :authenticated_root
      end
    end
  end

  devise_scope :admin do
    authenticated :admin do
      namespace :admins do
        get 'dashboard/index', as: :authenticated_root
        get 'dashboard/servers', as: :servers
        get 'dashboard/new_server', as: :new_server
        get 'dashboard/edit_server/:id', to: 'dashboard#edit_server', as: :edit_server
        post 'dashboard/create_server', as: :create_server
        patch 'dashboard/update_server/:id', to: 'dashboard#update_server', as: :update_server
        delete 'dashboard/destroy_server/:id', to: 'dashboard#destroy_server', as: :destroy_server
      end
    end
  end

  resources :events
  resources :participants

  root to: "home#index"
  post '/register/:event_id/:participant_id', to: 'events#register_participant', as: :register_participant
  get '/remove_participant/:event_id/:participant_id', to: 'events#remove_participant', as: :remove_participant
  get '/export/:event_id', to: 'participants#export', as: :export_participant
  post '/import/:event_id', to: 'participants#import', as: :import_participant












  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
