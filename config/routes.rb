# frozen_string_literal: true

# == Route Map

#

Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  namespace :admin do
    get "/" => "homes#top"
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :categories, except: [:show]
  end

  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
    resources :users, only: [:show, :edit, :update] do
      member do
        get :unsubscribe
        patch :withdrawal
      end
    end
    resources :posts, except: [:destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
