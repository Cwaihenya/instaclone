Rails.application.routes.draw do
  resources :users , only: [:new, :create, :show]
  resources :posts do
    collection do
      post :confirm
    end
  end
resources :sessions, only: [:new, :create, :destroy]
mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
