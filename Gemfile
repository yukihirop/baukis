source 'https://rubygems.org'

# ルビーのバージョンは記しておく
ruby '2.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use mysql as the database for Active Record

# mysql2は、0.4.4はバグである。
gem 'mysql2', '~> 0.3.20'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# V8 JavaScriptインタプリタをrubyに組み込むためのgemパッケージ
gem 'therubyracer', platforms: :ruby
# パスワードの暗号化で使用
gem 'bcrypt', '~> 3.1.7'
# XML/HTMLの解析・生成のためのgemパッケージです。
gem 'nokogiri', '~> 1.6.1'
# railsが出力するエラーメッセージ、日付、時刻、通過単位などの翻訳ファイルをあつめたgemパッケージ
gem 'rails-i18n', '~> 4.0.1'

# 外部キーを設定する機能
gem 'foreigner', '~> 1.6.1'
gem 'kaminari', '~> 0.15.1'
gem 'quiet_assets', '~> 1.0.2', group: :development

group :test do
  gem 'rspec-rails', '~> 3.0.0.beta2'
  gem 'capybara', '~> 2.2.1'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'spring-commands-rspec'
end
