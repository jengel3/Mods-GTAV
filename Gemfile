source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.2.1'

# Minify
gem 'uglifier', '2.7.0'
gem 'sass-rails'

# Front end
gem 'jquery-rails'
gem 'kramdown'
gem 'jquery-ui-rails'

# API 
gem "active_model_serializers", "~> 0.8.0"

# Authentication
gem 'devise'
gem 'omniauth-steam'

# File uploads
gem 'carrierwave-mongoid'

# Database
gem 'mongoid'
gem 'bson_ext'
gem 'mongoid_paranoia'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'mongoid-slug'
gem 'kaminari'
gem 'sanitize'

# Searching
gem 'mongoid-elasticsearch'

# Caching
gem 'redis'

# Background tasks
gem 'sidekiq'

# Email compiler
gem 'premailer-rails'

# Windows Rails fix
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

# Use passenger in production
group :production do
  gem 'passenger'
end

group :staging do
  gem 'rails_12factor'
end

# Use thin in development
group :development do
  gem 'better_errors'
  gem 'thin'
end

group :development, :staging, :test do
  gem 'faker'
end

group :development, :test do 
  gem 'rspec-rails' 
  gem 'factory_girl_rails'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
end 

group :test do 
  gem 'capybara'
end
