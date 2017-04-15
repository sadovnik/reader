require 'uri'

module SourceHelper
  GOOGLE_S2_FAVICONS_ENDPOINT = 'https://www.google.com/s2/favicons?domain='

  def favicon_url(source)
    GOOGLE_S2_FAVICONS_ENDPOINT + source.site_url
  end
end
