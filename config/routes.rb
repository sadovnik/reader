Rails.application.routes.draw do
  root 'invites#new'

  post 'invites/new', to: 'invites#new'
  post 'invites', to: 'invites#create'
  get 'invites/done', to: 'invites#done'
  get 'invites/bummer', to: 'invites#bummer'
  get 'invites/:key/use', to: 'invites#use'

  post 'logout', to: 'sessions#destroy'

  get 'feed', to: 'post_entries#index'
  get 'favorites', to: 'post_entries#index_favorite'
  put 'feed/entries/:id/status', to: 'post_entries#update_status', as: 'update_status'
  put 'feed/entries/:id/favorite_status', to: 'post_entries#update_favorite_status', as: 'update_favorite_status'
  put 'feed/entries/status', to: 'post_entries#mark_all_read', as: 'mark_all_read'

  get 'subscriptions', to: 'subscriptions#index'
  get 'subscriptions/new', to: 'subscriptions#new'
  post 'subscriptions', to: 'subscriptions#create'
  delete 'subscriptions/:id', to: 'subscriptions#destroy', as: 'unsubscribe'
end
