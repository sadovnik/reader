# Fetches source
class SourceFetcher
  def self.fetch(url)
    source = Source.find_by_url(url)

    return source unless source.nil?

    feed = Feedjira::Feed.fetch_and_parse(url)

    SourceBuilder.build(feed)
  end
end
