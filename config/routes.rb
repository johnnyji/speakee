Rails.application.routes.draw do
  root "confessions#index"
  resources :confessions
  resources :sessions

  match "/auth/facebook/callback", to: "sessions#create", as: "signin", via: :get
  match "/auth/failure", to: redirect("/"), via: :get
  match "signout", to: "sessions#destroy", as: "signout", via: :get
  
end
