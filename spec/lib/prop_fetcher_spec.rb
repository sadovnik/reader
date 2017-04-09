require 'ostruct'
require 'prop_fetcher'

describe PropFetcher do
  describe '#fetch' do
    it 'works' do
      source = OpenStruct.new(foo: 'bar', baz: 'qux')
      map = { 'foo' => 'one', 'baz' => 'two' }
      result = PropFetcher.fetch(source, map)

      expect(result).to eq({ 'one' => 'bar', 'two' => 'qux' })
    end
  end
end
