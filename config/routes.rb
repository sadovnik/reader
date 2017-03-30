Rails.application.routes.draw do
  root 'invites#new'

  post 'invites/new', to: 'invites#new'
  post 'invites', to: 'invites#create'
  get 'invites/done', to: 'invites#done'
  get 'invites/bummer', to: 'invites#bummer'
  get 'invites/:key/use', to: 'invites#use'
  get 'feed', to: 'entries#index'
  post 'logout', to: 'sessions#destroy'
end
