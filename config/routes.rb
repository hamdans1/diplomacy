Rails.application.routes.draw do

  resources :groups do
    resources :campaigns, except: [:index]
  end

  get 'about' => 'welcome#about'

  get 'welcome/index'
  root 'welcome#index'

end
