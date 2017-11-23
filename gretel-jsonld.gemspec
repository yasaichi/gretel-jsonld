$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gretel/jsonld/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gretel-jsonld"
  s.version     = Gretel::Jsonld::VERSION
  s.authors     = ["yasaichi"]
  s.email       = ["yasaichi@users.noreply.github.com"]
  s.homepage    = "https://github.com/yasaichi/gretel-jsonld"
  s.summary     = "Gretel extension for supporting JSON-LD breadcrumbs"
  s.description = "gretel-jsonld enables gretel gem to handle JSON-LD based breadcrumbs."
  s.license     = "MIT"

  s.files = Dir["CHANGELOG.md", "lib/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "gretel", ">= 3.0.0"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "reek"
  s.add_development_dependency "rspec-its"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "simplecov"
end
