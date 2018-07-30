Rails.application.routes.draw do
  devise_for :users

  resources :users

  resources :tournaments, path: 't', except: %i[index], shallow: true do
    resources :teams do
      member do
        post 'toggle'
      end
    end
    resources :races do
      member do
        post 'toggle'
      end
    end
    resources :rounds do
      member do
        post 'redraw'
      end
      member do
        post 'reset'
      end
      resources :tables do
        member do
          post 'reset'
        end
        resources :scores
      end
    end
  end

  resources :tournaments, path: '', only: %i[index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tournaments#index'
end
