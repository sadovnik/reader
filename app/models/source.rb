class Source < ApplicationRecord
  has_many :posts
  has_many :subscriptions
end
