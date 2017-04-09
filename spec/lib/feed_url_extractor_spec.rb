require 'feed_url_extractor'

# TODO: move to libhelper
def extract_fixture(name)
  path = File.expand_path("./fixtures/feed_url_extractor/#{name}.html", __dir__)
  File.read(path)
end

describe FeedUrlExtractor do
  describe '#extract_first' do
    regular_cases = { 'jvns.ca' => '/atom.xml',
                      'ilyabirman.ru' => 'http://ilyabirman.ru/meanwhile/rss/' }

    regular_cases.each do |page, expected|
      it "extracts first occured feed url (expample #{page})" do
        page = extract_fixture(page)

        actual = FeedUrlExtractor.extract_first(page)

        assert_equal actual, expected
      end
    end

    it 'raises `FeedUrlExtractor::NothingFound` if no feed found' do
      page = extract_fixture('reader-app.herokuapp.com')

      assert_raises FeedUrlExtractor::NothingFound do
        FeedUrlExtractor.extract_first(page)
      end
    end
  end
end
