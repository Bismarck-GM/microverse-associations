Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :events
  post "events/:id/attend", to: "events#attend", as: "attend_event"
  post "events/:id/invite", to: "events#invite", as: "invite_to_event"
  root "home#index"
end
