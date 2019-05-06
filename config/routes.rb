Rails.application.routes.draw do

  resources :groups do
    resources :campaigns, except: [:index]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  get 'welcome/index'
  root 'welcome#index'

end
