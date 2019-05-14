Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  resources :books do
    resources :reviews, only: [:new, :create]
  end

  resources :authors, only: [:show, :destroy]

  resources :reviews, except: :index

  resources :users, only: [:show, :destroy]

end
