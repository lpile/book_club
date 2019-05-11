Rails.application.routes.draw do  
  resources :welcome, only: :index

  resources :books do
    resources :reviews, only: [:new, :create]
  end

  resources :authors, only: :show

  resources :reviews, except: :index
end
