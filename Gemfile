source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'

gem 'acts_as_paranoid', '~> 0.6.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', '~> 2.5'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'pg', '~> 1.1.3'
gem 'puma', '~> 3.11'


group :development, :test do
  gem 'factory_bot_rails', '~> 4.11.1'
  gem 'pry-byebug', '~> 3.3.0', platform: :mri
  gem 'rspec-rails', '~> 3.8.1'
  gem 'rspec-core', '~> 3.8.0'
end

group :development do
  gem 'annotate', '~> 2.7.4'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.6.1'
  gem 'faker', '~> 1.7.3'
  gem 'shoulda-matchers', '~> 3.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]