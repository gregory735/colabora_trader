Rails.application.routes.draw do
  devise_for :collaborators
  
  root to: 'home#index'

  resources :product_categories, only: [:index, :show, :new, :create]
end
