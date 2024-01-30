Rails.application.routes.draw do
  root to: "home#index"

  namespace :admin do
    resources :users
  end
  scope module: 'api' do
    namespace :v1 do
      # post 'login', to: "sessions#create"
      devise_for  :users,
        path: '',
        path_names: { session:       'login',
                      sign_out:      'logout',
                      registration:  'sign_up' }

      resources :users
    end
  end
end
