source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem "redis"
gem "sidekiq"
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

gem "devise", "~> 4.9"

gem "active_model_serializers", "~> 0.10.14"

gem "config", "~> 5.1"

gem "kaminari", "~> 1.2"

gem 'jwt'

gem 'dotenv'

gem "rswag"

gem 'activeadmin'

gem "sassc-rails"

gem 'ckeditor'

gem 'carrierwave', '~> 3.0'

gem 'mini_magick'

gem 'cancancan'

gem 'slim'

gem 'sass-rails'

gem 'bootstrap', '~> 5.3.2'

gem 'jquery-rails'

group :development do
  gem "capistrano", "~> 3.17", require: false
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  gem "rspec-rails"
  gem "rswag-specs"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
