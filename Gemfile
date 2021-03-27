source 'https://rubygems.org'

ruby '2.3.5'

gem 'rails', '~> 5.2.5'

# infrastructure
gem 'puma', '~> 3.0'
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production
gem 'sidekiq', group: :production

# frontend
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'sass-rails', '~> 5.0'
gem 'rails_real_favicon', group: :development

# libs
gem 'state_machines'
gem 'state_machines-activerecord'
gem 'feedjira'
gem 'nokogiri', '~> 1'

# helpers
gem 'annotate', group: :development

group :development, :test do
  gem 'fakeweb'
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'foreman'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
