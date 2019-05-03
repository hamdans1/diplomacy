Rails.application.routes.draw do

  resources :groups
  resources :campaigns

  get 'about' => 'welcome#about'

  get 'welcome/index'
  root 'welcome#index'

end
