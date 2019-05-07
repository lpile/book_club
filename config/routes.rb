Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/authors/:id', to: 'authors#show'

  resources :books
end
