Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end
      
      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end

      namespace :customers do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end

      resources :merchants, only: [:index, :show] do
        get '/items', to: 'merchants/items#index'
      end
      
      resources :items, only: [:index, :show]
      resources :customers, only: [:index, :show]

    end
  end
end
