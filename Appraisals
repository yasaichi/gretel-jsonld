# frozen_string_literal: true

appraise "rails-5x" do
  gem "gretel", "~> 3.0"
  gem "rails", "~> 5.0"
  # sqlite3 1.6.x may resolve to a Linux gem requiring Ruby 2.7+, so keep
  # the Rails 5 jobs on 1.5.x for Ruby 2.5.
  gem "sqlite3", "~> 1.5.0"
end

appraise "rails-6x" do
  # ActiveSupport 6.1 fails to boot with an uninitialized Logger constant
  # because concurrent-ruby 1.3.5+ no longer loads logger.
  gem "concurrent-ruby", "< 1.3.5"
  gem "gretel", "~> 3.0"
  gem "rails", "~> 6.0"
end

appraise "rails-7x" do
  gem "gretel", "~> 3.0"
  gem "rails", "~> 7.0"
end

appraise "rails-8x" do
  gem "gretel", "~> 3.0"
  gem "rails", "~> 8.0"
end
