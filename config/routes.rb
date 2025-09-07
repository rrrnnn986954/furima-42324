Rails.application.routes.draw do
  devise_for :users, sign_out_via: :delete
  root "items#index"

  resources :items do
    resources :orders, only: [:index, :create]
  end
end
