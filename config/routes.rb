Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :admin do
    resources :users
  end

  scope module: 'api', format: "json" do
    namespace :v1 do
      devise_for  :users,
        path: '',
        path_names: { session:       'login',
                      sign_out:      'logout',
                      registration:  'sign_up' }

      resources :users
      resources :api_docs, only: [:index]
    end
  end
end
