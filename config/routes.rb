Rails.application.routes.draw do
  devise_for :users

  root 'questions#index'

  resources :questions, except: [:edit] do
    resources :answers, shallow: true, except: [:index, :show, :new] do
      post :mark_as_best, on: :member
      post :like, on: :member
      post :unlike, on: :member
    end

    post :like, on: :member
    post :unlike, on: :member
  end

  resources :rewards, only: [:index]
  resources :attachments, only: [:destroy]
  resources :links, only: [:destroy]

  mount ActionCable.server => '/cable'
end
