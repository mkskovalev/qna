Rails.application.routes.draw do
  devise_for :users

  root 'questions#index'

  resources :questions, except: [:edit] do
    resources :answers, shallow: true, except: [:index, :show, :new]
  end
end
