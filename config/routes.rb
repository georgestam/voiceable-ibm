Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  
  scope '(:locale)', locale: /en|es/ do

    root to: "pages#index"
    
    get 'about', to: "pages#about"
    get 'contribute', to: "pages#contribute"
    get 'contact', to: "pages#contact"
    get 'questions', to: "pages#questions"
    
    scope '/dashboard' do
      root to: "users#main", as: :dashboard
      get "welcome", to: "users#welcome", as: :welcome
    end
    
    namespace :api, defaults: { format: :json } do
      namespace :respira do
        namespace :v1 do
          resources :recordings, only: %i[index show update]
        end
      end
    end
    
  end
  
end
