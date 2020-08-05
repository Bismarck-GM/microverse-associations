Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  get "invites", to: "users#invites", as: "user_invites"

  resources :sessions, only: [:new, :create]
  delete "sessions", to: "sessions#destroy", as: "destroy_session"

  resources :events
  post "events/:id/attend", to: "events#attend", as: "attend_event"
  post "events/:id/invite", to: "events#invite", as: "invite_to_event"


  root "home#index"
end
