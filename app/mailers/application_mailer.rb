class ApplicationMailer < ActionMailer::Base
  default from: "robot@#{ENV['HOST']}"
  layout 'mailer'
end
