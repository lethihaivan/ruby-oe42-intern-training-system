Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users, only: :show
    namespace :supervisor do
      resources :courses
      resources :courses do
        member do
          get "assign_trainee"
          post "add_trainee" 
          delete "delete_trainee"
          post "start"
        end
      end
    end
    
  end
end
