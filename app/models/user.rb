class User < ApplicationRecord
  has_many :post_entries
  has_many :subscriptions
  has_many :sources, through: :subscriptions

  def subscribe(source)
    Subscription.create(user: self, source: source)
  end

  def entries
    post_entries
  end
end
