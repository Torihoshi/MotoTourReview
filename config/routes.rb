# frozen_string_literal: true

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
    get "users" => redirect("/users/sign_up")
  end

  namespace :admin do
    get "/" => "homes#top"
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
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
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# == Route Map
#
#                                   Prefix Verb   URI Pattern                                                                                       Controller#Action
#                        new_admin_session GET    /admin/sign_in(.:format)                                                                          admin/sessions#new
#                            admin_session POST   /admin/sign_in(.:format)                                                                          admin/sessions#create
#                    destroy_admin_session DELETE /admin/sign_out(.:format)                                                                         admin/sessions#destroy
#                         new_user_session GET    /users/sign_in(.:format)                                                                          public/sessions#new
#                             user_session POST   /users/sign_in(.:format)                                                                          public/sessions#create
#                     destroy_user_session DELETE /users/sign_out(.:format)                                                                         public/sessions#destroy
#                 cancel_user_registration GET    /users/cancel(.:format)                                                                           public/registrations#cancel
#                    new_user_registration GET    /users/sign_up(.:format)                                                                          public/registrations#new
#                   edit_user_registration GET    /users/edit(.:format)                                                                             public/registrations#edit
#                        user_registration PATCH  /users(.:format)                                                                                  public/registrations#update
#                                          PUT    /users(.:format)                                                                                  public/registrations#update
#                                          DELETE /users(.:format)                                                                                  public/registrations#destroy
#                                          POST   /users(.:format)                                                                                  public/registrations#create
#                      users_guest_sign_in POST   /users/guest_sign_in(.:format)                                                                    public/sessions#guest_sign_in
#                                    admin GET    /admin(.:format)                                                                                  admin/homes#top
#                          edit_admin_user GET    /admin/users/:id/edit(.:format)                                                                   admin/users#edit
#                               admin_user GET    /admin/users/:id(.:format)                                                                        admin/users#show
#                                          PATCH  /admin/users/:id(.:format)                                                                        admin/users#update
#                                          PUT    /admin/users/:id(.:format)                                                                        admin/users#update
#                              admin_posts GET    /admin/posts(.:format)                                                                            admin/posts#index
#                          edit_admin_post GET    /admin/posts/:id/edit(.:format)                                                                   admin/posts#edit
#                               admin_post GET    /admin/posts/:id(.:format)                                                                        admin/posts#show
#                                          PATCH  /admin/posts/:id(.:format)                                                                        admin/posts#update
#                                          PUT    /admin/posts/:id(.:format)                                                                        admin/posts#update
#                         admin_categories GET    /admin/categories(.:format)                                                                       admin/categories#index
#                                          POST   /admin/categories(.:format)                                                                       admin/categories#create
#                       new_admin_category GET    /admin/categories/new(.:format)                                                                   admin/categories#new
#                      edit_admin_category GET    /admin/categories/:id/edit(.:format)                                                              admin/categories#edit
#                           admin_category PATCH  /admin/categories/:id(.:format)                                                                   admin/categories#update
#                                          PUT    /admin/categories/:id(.:format)                                                                   admin/categories#update
#                                          DELETE /admin/categories/:id(.:format)                                                                   admin/categories#destroy
#                                     root GET    /                                                                                                 public/homes#top
#                                    about GET    /about(.:format)                                                                                  public/homes#about
#                         unsubscribe_user GET    /users/:id/unsubscribe(.:format)                                                                  public/users#unsubscribe
#                          withdrawal_user PATCH  /users/:id/withdrawal(.:format)                                                                   public/users#withdrawal
#                                edit_user GET    /users/:id/edit(.:format)                                                                         public/users#edit
#                                     user GET    /users/:id(.:format)                                                                              public/users#show
#                                          PATCH  /users/:id(.:format)                                                                              public/users#update
#                                          PUT    /users/:id(.:format)                                                                              public/users#update
#                            post_comments POST   /posts/:post_id/comments(.:format)                                                                public/comments#create
#                             post_comment DELETE /posts/:post_id/comments/:id(.:format)                                                            public/comments#destroy
#                           post_favorites DELETE /posts/:post_id/favorites(.:format)                                                               public/favorites#destroy
#                                          POST   /posts/:post_id/favorites(.:format)                                                               public/favorites#create
#                                    posts GET    /posts(.:format)                                                                                  public/posts#index
#                                          POST   /posts(.:format)                                                                                  public/posts#create
#                                 new_post GET    /posts/new(.:format)                                                                              public/posts#new
#                                edit_post GET    /posts/:id/edit(.:format)                                                                         public/posts#edit
#                                     post GET    /posts/:id(.:format)                                                                              public/posts#show
#                                          PATCH  /posts/:id(.:format)                                                                              public/posts#update
#                                          PUT    /posts/:id(.:format)                                                                              public/posts#update
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#        new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
#       edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                                 rails/conductor/action_mailbox/inbound_emails#edit
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
#                                          PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
#                                          PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
#                                          DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#destroy
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
