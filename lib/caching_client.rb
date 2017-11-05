# Caches every `get` request into memory
class CachingClient
  def initialize(cache: nil, client: nil)
    @cache = cache || ActiveSupport::Cache::MemoryStore.new
    @client = client || Faraday.new
  end

  def get(url)
    return @cache.read(url) if @cache.exist?(url)

    response = @client.get(url)

    @cache.write(url, response)

    response
  end
end
