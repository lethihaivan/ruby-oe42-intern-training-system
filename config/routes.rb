Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    resources :users, only: [:show]
  end
end
