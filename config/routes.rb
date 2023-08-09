# == Route Map

#

Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get "/" => "homes#top"
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :categories, except: [:show]
  end

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        get :unsubscribe
      end
    end
    resources :posts, only: [:index, :show, :new, :create, :edit, :update]
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
