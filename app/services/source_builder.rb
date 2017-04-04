require 'fetcher'

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
    source = Source.create!(Fetcher.fetch(feedjira_feed, SOURCE_MAP))

    source.posts = feedjira_feed.entries.map do |feedjira_entry|
      PostBuilder.build(feedjira_entry)
    end

    source
  end
end
