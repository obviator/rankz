Rails.application.routes.draw do
  devise_for :users

  resources :tournaments, path: '', only: %i[index]

  resources :tournaments, path: 't', except: %i[index] do
    resources :teams, shallow: true
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tournaments#index'
end
