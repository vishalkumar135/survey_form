Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :surveys, only: [:create]
      resources :responses, only: [:create, :show, :update]
      get 'users/:user_identifier/responses', to: 'users#responses'
    end
  end
end