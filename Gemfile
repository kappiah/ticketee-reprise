source "https://rubygems.org"

ruby "2.2.4"

gem "autoprefixer-rails"
gem "bourbon", "~> 4.2.0"
gem "carrierwave"
gem "clearance"
gem "delayed_job_active_record"
gem "email_validator"
gem "flutie"
gem "font-awesome-rails"
gem "high_voltage"
gem "i18n-tasks"
gem "listen"
gem "jquery-rails"
gem "neat", "~> 1.7.0"
gem "normalize-rails", "~> 3.0.0"
gem 'pundit', "~> 1.0.1"
gem "pg"
gem "pg_search"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 5.0.0.beta3"
gem "recipient_interceptor"
gem "refills"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "title"
gem "uglifier"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bundler-audit", require: false
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.5.0.beta1"
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "email_spec"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
end
