Rails.application.routes.draw do

  devise_for :users, {
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root to: "podcasts#index"

  resources :posts

  resources :podcasts

  get "/admin",
    to: redirect( "/users/sign_in" )

  get "/rss/podcasts", to: redirect("http://taoofcomedy.libsyn.com/rss")
    # to: 'podcasts#index',
    # as: :podcasts_rss,
    # defaults: { format: 'rss' }

  get "/news",
    to: "pages#news",
    as: :news_path

  get "/about",
    to: "pages#about",
    as: :about_path

  get "/donate",
    to: "pages#donate",
    as: :donate_path

  post "/donate/process",
    to: 'pages#donate_process',
    as: :donate_process

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
