require 'fetcher'

# Converts Feedjira::RSSEntry into Post
class PostBuilder
  # Feedjira::Parser::RSSEntry => Post
  POST_MAP = {
    'entry_id' => 'internal_id',
    'title' => 'title',
    'url' => 'url',
    'summary' => 'summary',
    'published' => 'published_at'
  }

  def self.build(feedjira_entry, source)
    fetched_attrs = Fetcher.fetch(feedjira_entry, POST_MAP)
    Post.create!(fetched_attrs.merge(source: source))
  end
end
