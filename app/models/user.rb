class User < ApplicationRecord
  has_many :post_entries
  has_many :subscriptions
  has_many :sources, through: :subscriptions

  def subscribe(source)
    raise 'Already subscribed' if subscribed?(source)

    subscription = Subscription.create(user: self, source: source)

    source.posts.each do |post|
      post.populize_entry(self)
    end

    subscription
  end

  def subscribed?(source)
    subscriptions.where(source_id: source.id).exists?
  end

  def entries
    post_entries
  end
end
