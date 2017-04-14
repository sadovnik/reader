require 'uri'
require 'feed_fetcher'

class FeedValidator < ActiveModel::EachValidator
  module Errors
    NOT_A_FEED = 'This is not RSS or Atom feed.'
    UNABLE_TO_FIND_FEED = "Couldn't find any feed on the given page. Could you please provide the exact link?"
    NOT_AVAILABLE_MESSAGE = "Can't fetch this feed. Seems like site is down or link is broken."
    LINK_IS_WEIRD = 'This link is kinda weird'
  end

  def validate_each(record, attribute, value)
    return unless record.errors[attribute].blank?

    FeedFetcher.new(record.client).fetch(value)
  rescue Feedjira::NoParserAvailable
  rescue FeedFetcher::NoContentTypeError
    record.errors[attribute] << Errors::NOT_A_FEED
  rescue Faraday::ConnectionFailed, Feedjira::FetchFailure
    record.errors[attribute] << Errors::NOT_AVAILABLE
  rescue FeedUrlExtractor::NothingFound
    record.errors[attribute] << Errors::UNABLE_TO_FIND_FEED
  end
end
