require 'nokogiri'

module FeedUrlExtractor
  CSS_SELECTOR = 'link[rel="alternate"]'
  MIME_TYPES = [
    'application/rss+xml',
    'application/atom+xml'
  ]

  def self.extract_first(page)
    nodes = Nokogiri::HTML(page)
    link_nodes = nodes.css(CSS_SELECTOR)

    first_feed_node = link_nodes.detect do |link|
      attributes = link.attributes

      attributes.has_key?('type') &&
        MIME_TYPES.include?(attributes['type'].value) &&
        attributes.has_key?('href')
    end

    return if first_feed_node.nil?

    first_feed_node.attributes['href'].value
  end
end
