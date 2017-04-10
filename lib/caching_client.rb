# Caches every `get` request
class CachingClient
  def initialize
    @cache = {}
  end

  def get(url)
    return @cache[url] if @cache.has_key?(url)

    response = Faraday.get(url)

    @cache[url] = response

    response
  end
end
