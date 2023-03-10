Rails.application.routes.draw do
  devise_for :users

  resources :emails
  root "emails#index"
end
