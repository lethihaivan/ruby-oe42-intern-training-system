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
        resources :course_subjects, only: :show do
          member do
            patch :finish
            patch :start
          end
        end
      end
      resources :courses do
        member do
          get :assign_trainee
          post :add_trainee 
          delete :delete_trainee
          post :start
          patch :finish
        end
      end
    end
    namespace :trainee do
      root "courses#index"
      resources :user_courses, only: :show
      resources :course_subjects, only: :show
      resources :user_subjects, only: :show do
        member do
          patch :finish
        end
        resources :tasks, only: :show do
          member do
            post :receive
            patch :finish
          end
        end
      end
    end
  end
end
