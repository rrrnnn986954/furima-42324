Rails.application.routes.draw do
  devise_for :users, sign_out_via: :delete
  root "items#index"
  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
