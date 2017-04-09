module PropFetcher
  # Fetches attributes from target object, names it by given map
  # and returns result as hash.
  #
  # Example:
  #
  #   source = OpenStruct.new(foo: 'bar', baz: 'qux')
  #   map = { 'foo' => 'one', 'baz' => 'two' }
  #   result = Fetcher.fetch(source, map)
  #   => {"one"=>"bar", "two"=>"qux"}
  #
  def self.fetch(target, map)
    map.reduce({}) do |acc, (from, to)|
      acc.merge({ to => target.send(from) })
    end
  end
end
