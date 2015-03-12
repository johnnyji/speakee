Rails.application.routes.draw do
  root "confessions#index"
  resource :confessions
  
end
