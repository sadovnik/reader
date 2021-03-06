require 'prop_fetcher'

# Converts Feedjira::Feed into Source
class SourceBuilder
  # Feedjira::Feed => Source
  SOURCE_MAP = {
    'title' => 'title',
    'description' => 'description',
    'feed_url' => 'url',
    'url' => 'site_url'
  }

  def self.build(feedjira_feed)
    source = Source.create!(PropFetcher.fetch(feedjira_feed, SOURCE_MAP))

    source.posts = feedjira_feed.entries.map do |feedjira_entry|
      PostBuilder.build(feedjira_entry, source)
    end

    source
  end
end
