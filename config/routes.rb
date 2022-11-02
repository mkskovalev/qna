Rails.application.routes.draw do
  devise_for :users

  root 'questions#index'

  resources :questions, except: [:edit] do
    resources :answers, shallow: true, except: [:index, :show, :new] do
      post :mark_as_best, on: :member
    end
  end

  resources :rewards, only: [:index]
  resources :attachments, only: [:destroy]
  resources :links, only: [:destroy]
end
