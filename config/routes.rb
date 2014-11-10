Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy] do 
    member do
      post "downvote"
      post "upvote"
    end
  end
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: :new
    member do
      post "downvote"
      post "upvote"
    end
  end
  resources :comments, only: [:show, :create] do
      member do
        post "downvote"
        post "upvote"
      end
    end
  root to: redirect("/subs")
end
