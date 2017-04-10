# Fetches source
class SourceFetcher
  def initialize(client)
    @client = client
  end

  def fetch(url)
    source = Source.find_by_url(url)

    return source unless source.nil?

    fetch_result = FeedFetcher.new(@client).fetch(url)

    source = SourceBuilder.build(fetch_result[:feed])

    source.url = fetch_result[:url]

    source.save!

    source
  end
end
