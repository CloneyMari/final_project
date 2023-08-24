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
      resource :invite, only: :show
      resources :lottery, only: [ :show, :index, :create]
      resources :shop
    end
  end

  constraints(AdminDomainConstraint.new) do
    namespace 'admin', path: '' do
      devise_for :users, controllers: {
        sessions: 'admin/sessions'
      }, as: :admin
      root 'home#index'
      resources :users, only: :index
      resources :items, except: :show do
        member do
          put :start
          put :pause
          put :end
          put :cancel
        end
      end
      resources :categories, except: :show
      resources :winners, only: :index do
        member do
         put :submit
         put :pay
         put :ship
         put :deliver
         put :publish
         put :remove_publish
        end
      end
      resources :orders, only: :index do
        member do
          put :pay
          put :cancel
        end
      end
      resources :offers, except: :show
      resources :bets, only: :index do
        put :cancel
      end
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
