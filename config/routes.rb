Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :events
  post "events/:id/attend", to: "events#attend", as: "attend_event"
  post "events/:id/invite", to: "events#invite", as: "invite_to_event"
end
