source 'https://rubygems.org'


gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bower-rails'
gem "foreman"
gem 'angular-rails-templates'
gem 'sprockets', '2.11.0'

group :test, :development do
  gem 'sqlite3'
  gem "rspec"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem 'teaspoon', "0.7.9"
  gem 'phantomjs'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production, :staging do
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
end

