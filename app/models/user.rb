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

  def unsubscribe(source)
    raise 'Not subscribed' unless subscribed?(source)

    transaction do
      subscription_for(source).destroy_all
      entries.joins(:post).where('posts.source_id = ?', source.id).delete_all
    end
  end

  def subscribed?(source)
    subscription_for(source).exists?
  end

  def subscription_for(source)
    subscriptions.where(source_id: source.id)
  end

  def entries
    post_entries
  end
end
