Rails.application.routes.draw do
  root "confessions#index"
  resources :confessions
  
end
