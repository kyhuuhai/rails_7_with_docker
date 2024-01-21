Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  namespace :admin do
    resources :users
  end

  scope module: 'api' do
    namespace :v1 do
      devise_for :users
      resources :users
    end
  end
end
