Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  constraints(ClientDomainConstraint.new) do
    scope module: :client do
      devise_for :users, controllers: {
        registrations: 'client/registrations',
        sessions: 'client/sessions'
      }
      root 'home#index', as: :client_root
    end
  end

  constraints(AdminDomainConstraint.new) do
    namespace 'admin', path: '' do
      devise_for :users, controllers: {
        sessions: 'admin/sessions'
      }, as: :admin
      root 'home#index', as: :admin_root
    end
  end
end
