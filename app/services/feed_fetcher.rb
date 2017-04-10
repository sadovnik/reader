require 'feed_url_extractor'

class FeedFetcher
  class NoContentTypeError < StandardError
    def message
      'Content-Type header is required'
    end
  end

  def initialize(client)
    @client = client
  end

  def fetch(url)
    response = @client.get(url)

    raise NoContentTypeError if response.headers.has_key?('content_type')

    response_content_type = response.headers[:content_type]

    if response_content_type.include?('text/html')
      raw_found_url = FeedUrlExtractor.extract_first(response.body)

      found_url = normalize_link(url, raw_found_url)

      raw_feed = @client.get(found_url).body

      return { feed: Feedjira::Feed.parse(raw_feed), url: found_url }
    end

    { feed: Feedjira::Feed.parse(response.body), url: url }
  end

  private

  # /feed.xml → https://example.com/feed.xml
  def normalize_link(parent_url, target_url)
    URI.join(parent_url, target_url)
  end
end
