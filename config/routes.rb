Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

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

  devise_for :users
  root to: "home#index"
end
