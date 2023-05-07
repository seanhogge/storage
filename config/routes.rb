Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#index"
  resources :users, only: [:show, :edit, :update]
  get "notifications/menu", to: "notifications#menu", as: "notifications_menu"
  resources :notifications, only: [:index, :show]

  post "/impersonation/:id", to: "impersonations#create", as: "impersonation"
  delete "/impersonation/:id", to: "impersonations#destroy"

  authenticated :user, lambda { |u| u.admin? } do
    namespace :admin do
      if defined?(Sidekiq)
        require "sidekiq/web"
        mount Sidekiq::Web => "/sidekiq"
      end

      resources :announcements
      resources :users, only: [:index, :edit, :update]
    end
  end

  if Rails.env.development? || Rails.env.test?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
