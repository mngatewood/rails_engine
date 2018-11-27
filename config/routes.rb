Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/find', to: 'find#show'
        get '/random', to: 'random#show'
      end

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/random', to: 'random#show'
      end

      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]

    end
  end
end
