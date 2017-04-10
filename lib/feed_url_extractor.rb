require 'nokogiri'

module FeedUrlExtractor
  class NothingFound < StandardError
    def message
      'Unable to find any feed urls'
    end
  end

  CSS_SELECTOR = 'link[rel="alternate"]'
  MIME_TYPES = [
    'application/rss+xml',
    'application/atom+xml'
  ]

  class << self
    def extract_first(page)
      first_url = extract_all(page).first

      raise NothingFound if first_url.nil?

      first_url
    end

    def extract_all(page)
      nodes = Nokogiri::HTML(page)
      link_nodes = nodes.css(CSS_SELECTOR)

      feed_nodes = link_nodes.find_all do |link|
        attributes = link.attributes

        attributes.has_key?('type') &&
          MIME_TYPES.include?(attributes['type'].value) &&
          attributes.has_key?('href')
      end

      feed_nodes.map do |node|
        node.attributes['href'].value
      end
    end
  end
end
