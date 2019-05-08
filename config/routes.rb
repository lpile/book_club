Rails.application.routes.draw do
  get '/', to: 'welcome#index'


  resources :books do
    resources :authors, except: :index, shallow: true
  end


end
