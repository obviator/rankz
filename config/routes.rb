Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :tournaments, path: 't', except: %i[index], shallow: true do
    member do
      get 'tiebreakers_edit'
      post 'tiebreakers_update'
    end
    resources :teams do
      post 'toggle', on: :member
    end
    resources :races do
      post 'toggle', on: :member
    end
    resources :rounds do
      member do
        post 'redraw'
        post 'reset'
      end
      resources :tables do
        post 'reset', on: :member
        resources :scores
      end
    end
  end

  resources :tournaments, path: '', only: %i[index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tournaments#index'
end
