Rails.application.routes.draw do
  root to: "home#index"

  namespace :admin do
    resources :users
  end

  scope module: 'api' do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'api/v1/sessions'
      }

      resources :users
    end
  end
end
