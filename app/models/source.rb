class Source < ApplicationRecord
  alias_attribute :subscribers, :users

  has_many :posts
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
