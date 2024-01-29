Rails.application.routes.draw do
  root to: "home#index"

  namespace :admin do
    resources :users
  end

  scope module: 'api' do
    namespace :v1 do
      post 'login', to: "sessions#create"
      resources :users
    end
  end
end
