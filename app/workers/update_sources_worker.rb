# Finds and saves new posts
module UpdateSourcesWorker
  class << self
    # returns count of new entries
    def perform
      Source.all.reduce(0) do |count, source|
        raw_feed = Feedjira::Feed.fetch_and_parse(source.url)

        refresh_source(source, raw_feed)

        entries_to_save = raw_feed.entries.reject do |entry|
          Post.where(internal_id: entry.entry_id).exists?
        end

        posts = entries_to_save.map do |entry|
          PostBuilder.build(entry, source)
        end

        source.subscribers.each do |user|
          posts.each do |post|
            post.populize_entry(user)
          end
        end

        count + entries_to_save.size
      end
    end

    private

    def refresh_source(source, raw_feed)
      source.update_attributes!(
        title: raw_feed.title,
        description: raw_feed.description
      )
    end
  end
end
