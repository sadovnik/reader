Rails.application.routes.draw do
  root 'invites#new'

  post 'invites/new', to: 'invites#new'
  post 'invites', to: 'invites#create'
  get 'invites/done', to: 'invites#done'
  get 'invites/bummer', to: 'invites#bummer'
  get 'invites/:key/use', to: 'invites#use'

  post 'logout', to: 'sessions#destroy'

  get 'feed', to: 'post_entries#index'
  get 'post_entries/:id/read', to: 'post_entries#read', as: 'read_entry'

  get 'subscriptions', to: 'subscriptions#index'
  get 'subscriptions/new', to: 'subscriptions#new'
  post 'subscriptions', to: 'subscriptions#create'
end
