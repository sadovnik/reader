require 'feed_url_extractor'

fixture = Fixture.new(File.expand_path(__FILE__))

describe FeedUrlExtractor do
  describe '#extract_first' do
    regular_cases = { 'jvns.ca' => '/atom.xml',
                      'ilyabirman.ru' => 'http://ilyabirman.ru/meanwhile/rss/',
                      'vc.ru' => 'https://vc.ru/feed' }

    regular_cases.each do |page, expected|
      it "extracts first occured feed url (expample #{page})" do
        page = fixture.get(page + '.html')

        actual = FeedUrlExtractor.extract_first(page)

        assert_equal actual, expected
      end
    end

    it 'raises `FeedUrlExtractor::NothingFound` if no feed found' do
      page = fixture.get('reader-app.herokuapp.com.html')

      assert_raises FeedUrlExtractor::NothingFound do
        FeedUrlExtractor.extract_first(page)
      end
    end
  end
end
