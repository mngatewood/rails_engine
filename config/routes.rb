Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/random', to: 'random#show'
      end

      resources :merchants, only: [:index, :show]

    end
  end
end