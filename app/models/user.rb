# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :post_entries, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
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

  def unread_entries
    entries
      .includes(:post)
      .where(status: :unread)
      .order('Posts.published_at DESC')
  end

  def favorite_entries
    entries.where(favorite_status: :favorite)
  end
end
