class FeedValidator < ActiveModel::EachValidator
  DEFAULT_MESSAGE = 'This is not an RSS or Atom feed.'
  DEFAULT_NOT_AVAILABLE_MESSAGE = "Can't fetch this feed. Seems like site is down or link is broken."

  def validate_each(record, attribute, value)
    return unless record.errors[attribute].blank?

    record.errors[attribute] << (options[:message] || DEFAULT_MESSAGE) unless feed?(value)
  rescue Faraday::ConnectionFailed, Feedjira::FetchFailure
    record.errors[attribute] << (options[:not_available_message] || DEFAULT_NOT_AVAILABLE_MESSAGE)
  end

  private

  def feed?(feed_url)
    Feedjira::Feed.fetch_and_parse(feed_url)
    true
  rescue Feedjira::NoParserAvailable
    false
  end
end
