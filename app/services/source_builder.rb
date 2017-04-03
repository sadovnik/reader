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

  # Feedjira::Parser::RSSEntry => Post
  POST_MAP = {
    'entry_id' => 'internal_id',
    'title' => 'title',
    'url' => 'url',
    'summary' => 'summary',
    'published' => 'published_at'
  }

  def self.build(feedjira_feed)
    source = Source.create!(Fetcher.fetch(feedjira_feed, SOURCE_MAP))

    source.posts = feedjira_feed.entries.map do |feedjira_entry|
      fetched_attrs = Fetcher.fetch(feedjira_entry, POST_MAP)
      Post.create!(fetched_attrs.merge(source: source))
    end

    source
  end
end
