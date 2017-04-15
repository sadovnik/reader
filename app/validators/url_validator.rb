class UrlValidator < ActiveModel::EachValidator
  URL_REGEXP = /https?:\/\/[^\s\.]+\.[^\s]{2,}/
  STARTS_WITH_HTTP_REGEXP = /^http/

  DEFAULT_MESSAGE = 'This link is weird.'
  TOO_STUPID_MESSAGE = <<-MSG
    Sorry, I'm too stupid to figure out how to manage links without an
    «http» part. Could you put it in please?
  MSG

  def validate_each(record, attribute, value)
    unless starts_with_http?(value)
      record.errors[attribute] << (options[:message] || TOO_STUPID_MESSAGE)
      return
    end

    unless value =~ URL_REGEXP
      record.errors[attribute] << (options[:message] || DEFAULT_MESSAGE)
    end
  end

  private

  def starts_with_http?(string)
    string =~ STARTS_WITH_HTTP_REGEXP
  end
end
