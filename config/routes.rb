Rails.application.routes.draw do
  resources :tournaments, path: '', only: :index
  resources :tournaments, path: 't', except: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tournaments#index'
end
