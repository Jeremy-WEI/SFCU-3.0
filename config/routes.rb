Rails.application.routes.draw do

  get 'maapps/export', to:  'maapps#export'

  resources :maapps

  resources :cbpapps

  resources :alapps

  resources :ulapps

  root 'maapps#new'
end
