Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  resources :books do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, except: [:index, :new, :create]
end
