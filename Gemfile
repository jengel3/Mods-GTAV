source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.2.1'

# Minify
gem 'uglifier', '2.7.0'

# Front end
gem 'jquery-rails'
gem 'kramdown'
gem 'jquery-ui-rails'

# API 
gem "active_model_serializers", "~> 0.8.0"
gem 'httparty'

# Authentication
gem 'devise'
gem 'omniauth-steam'

# File uploads
gem 'carrierwave'
gem 'mini_magick'
gem 'remotipart', github: 'Jake0oo0/remotipart'

# Database
gem 'pg'
gem 'friendly_id', '~> 5.1.0'
gem 'paranoia', '~> 2.1.1'
gem 'annotate', '~> 2.6.6'
gem 'elasticsearch-rails'
gem 'elasticsearch-model'

# Other
gem 'kaminari'
gem 'sanitize'

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
  gem 'rack-mini-profiler'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
end

group :development, :staging, :test do
  gem 'faker'
end

group :development, :test do 
  gem 'rspec-rails' 
  gem 'factory_girl_rails'
end 

group :test do 
  gem 'capybara'
end