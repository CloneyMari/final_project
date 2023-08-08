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
end
