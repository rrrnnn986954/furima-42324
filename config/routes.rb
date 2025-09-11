Rails.application.routes.draw do
  devise_for :users, sign_out_via: :delete
  root "items#index"

  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :items do
    resources :orders, only: [:index, :create]
  end
end
