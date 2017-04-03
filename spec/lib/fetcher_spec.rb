require 'ostruct'
require 'fetcher'

describe Fetcher do
  describe '#fetch' do
    it 'works' do
      source = OpenStruct.new(foo: 'bar', baz: 'qux')
      map = { 'foo' => 'one', 'baz' => 'two' }
      result = Fetcher.fetch(source, map)

      expect(result).to eq({ 'one' => 'bar', 'two' => 'qux' })
    end
  end
end
