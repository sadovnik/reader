class SubscriptionForm < Reader::Form
  attr_reader :user, :url

  def initialize(user, url = nil)
    @user = user
    @url = url
  end

  validates :url, presence: true,
                  url: true,
                  feed: true

  validate do |form|
    source = Source.find_by_url(form.url)

    next if source.nil?

    if form.user.subscriptions.where(source_id: source.id).exists?
      self.errors[:url] << 'You already subscribed to this feed.'
    end
  end
end
