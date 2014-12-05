''# == Route Map
#
#        Prefix Verb   URI Pattern                 Controller#Action
# alapps_export GET    /alapps/export(.:format)    alapps#export
#        maapps GET    /maapps(.:format)           maapps#index
#               POST   /maapps(.:format)           maapps#create
#     new_maapp GET    /maapps/new(.:format)       maapps#new
#    edit_maapp GET    /maapps/:id/edit(.:format)  maapps#edit
#         maapp GET    /maapps/:id(.:format)       maapps#show
#               PATCH  /maapps/:id(.:format)       maapps#update
#               PUT    /maapps/:id(.:format)       maapps#update
#               DELETE /maapps/:id(.:format)       maapps#destroy
#       cbpapps GET    /cbpapps(.:format)          cbpapps#index
#               POST   /cbpapps(.:format)          cbpapps#create
#    new_cbpapp GET    /cbpapps/new(.:format)      cbpapps#new
#   edit_cbpapp GET    /cbpapps/:id/edit(.:format) cbpapps#edit
#        cbpapp GET    /cbpapps/:id(.:format)      cbpapps#show
#               PATCH  /cbpapps/:id(.:format)      cbpapps#update
#               PUT    /cbpapps/:id(.:format)      cbpapps#update
#               DELETE /cbpapps/:id(.:format)      cbpapps#destroy
#        alapps GET    /alapps(.:format)           alapps#index
#               POST   /alapps(.:format)           alapps#create
#     new_alapp GET    /alapps/new(.:format)       alapps#new
#    edit_alapp GET    /alapps/:id/edit(.:format)  alapps#edit
#         alapp GET    /alapps/:id(.:format)       alapps#show
#               PATCH  /alapps/:id(.:format)       alapps#update
#               PUT    /alapps/:id(.:format)       alapps#update
#               DELETE /alapps/:id(.:format)       alapps#destroy
#        ulapps GET    /ulapps(.:format)           ulapps#index
#               POST   /ulapps(.:format)           ulapps#create
#     new_ulapp GET    /ulapps/new(.:format)       ulapps#new
#    edit_ulapp GET    /ulapps/:id/edit(.:format)  ulapps#edit
#         ulapp GET    /ulapps/:id(.:format)       ulapps#show
#               PATCH  /ulapps/:id(.:format)       ulapps#update
#               PUT    /ulapps/:id(.:format)       ulapps#update
#               DELETE /ulapps/:id(.:format)       ulapps#destroy
#          root GET    /                           maapps#new
#

Rails.application.routes.draw do


  get 'cbpapps/export', to: 'cbpapps#export'
  get 'main/index'
  get '/ulapps/export', to: 'ulapps#export'
  #get '/alapps/new', to: 'alapps#new'
  get '/alapps/export', to: 'alapps#export'
  get 'maapps/export', to:  'maapps#export'

  resources :maapps

  resources :cbpapps

  resources :alapps do
    post 'save', to: 'alapps#save', on: :member
  end

  resources :ulapps

  root 'main#index'

end
