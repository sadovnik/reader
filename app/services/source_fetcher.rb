# Fetches source
class SourceFetcher
  def initialize(client)
    @client = client
  end

  def fetch(url)
    source = Source.find_by_url(url)

    return source unless source.nil?

    feed, found_url = FeedFetcher.new(@client).fetch(url)

    source = SourceBuilder.build(feed)

    source.update_attributes!(
      url: found_url,
      site_url: feed.url
    )

    source
  end
end
