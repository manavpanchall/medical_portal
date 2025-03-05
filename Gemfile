source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'rails', '~> 7.0.4'
gem 'pg', '~> 1.4'
gem 'bcrypt', '~> 3.1.7'
gem 'chartkick', '~> 4.1'
gem 'groupdate', '~> 6.0'

group :development, :test do
  gem 'pry-byebug', '~> 3.9'
  gem 'rails_db', '~> 2.0'
end

group :development do
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'capybara', '~> 3.36'
  gem 'selenium-webdriver', '~> 4.0'
end