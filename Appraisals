# frozen_string_literal: true

appraise "gretel_3_rails_5" do
  gem "gretel", "~> 3.0"
  gem "rails", "~> 5.0"
  # sqlite3 1.6.x may resolve to a Linux gem requiring Ruby 2.7+, so keep
  # the Rails 5 jobs on 1.5.x for Ruby 2.5.
  gem "sqlite3", "~> 1.5.0"
end

appraise "gretel_4_rails_5" do
  # Gretel 4.1 moved view helper loading to a Railtie initializer. Keep the
  # Rails 5 boundary on 4.0.x to cover the earlier loading path as well.
  gem "gretel", "~> 4.0.0"
  gem "rails", "~> 5.1"
  gem "sqlite3", "~> 1.5.0"
end

appraise "gretel_4_rails_7" do
  gem "gretel", "~> 4.1"
  gem "rails", "~> 7.1.0"
end

appraise "gretel_5_rails_6" do
  # ActiveSupport 6.1 fails to boot with an uninitialized Logger constant
  # because concurrent-ruby 1.3.5+ no longer loads logger.
  gem "concurrent-ruby", "< 1.3.5"
  gem "gretel", "~> 5.0"
  gem "rails", "~> 6.1"
end

appraise "gretel_5_rails_8" do
  gem "gretel", "~> 5.0"
  gem "rails", "~> 8.0"
end
