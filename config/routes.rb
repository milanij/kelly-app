Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root to: "podcasts#index"

  resources :posts

  resources :podcasts

  get "/admin",
    to: redirect( "/users/sign_in" )


  get "/news",
    to: "pages#news",
    as: :news_path

  get "/calendar",
    to: "pages#calendar",
    as: :calendar_path

  get "/photos",
    to: "pages#photos",
    as: :photos_path

  get "/videos",
    to: "pages#videos",
    as: :videos_path

  get "/contact",
    to: "pages#contact",
    as: :contact_path

  namespace :admin do
    resources :posts

    resources :podcasts
  end

end
