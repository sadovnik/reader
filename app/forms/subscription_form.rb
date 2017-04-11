# The subscription form. Appears at /subscriptions/new
class SubscriptionForm < Reader::Form
  attr_reader :user, :url, :client

  def initialize(user, url = nil, client = nil)
    @user = user
    @url = url
    @client = client
  end

  validates :url, presence: true,
                  url: true,
                  feed: true

  validate do |form|
    source = Source.where('url = ? OR site_url = ?', @url, @url).first

    if source && form.user.subscribed?(source)
      self.errors[:url] << 'You already subscribed to this feed.'
    end
  end
end
