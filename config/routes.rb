Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  constraints(ClientDomainConstraint.new) do
    devise_for :users, controllers: {
      registrations: 'client/registrations',
      sessions: 'client/sessions'
    }
    scope module: :client do

      root 'home#index', as: :client_root
      resource :profiles, only: [:edit, :update, :show]
      resources :addresses, except: :show
    end
  end

  constraints(AdminDomainConstraint.new) do
    namespace 'admin', path: '' do
      devise_for :users, controllers: {
        sessions: 'admin/sessions'
      }, as: :admin
      root 'home#index'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end
      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end

      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end

      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end
end
