$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gretel/jsonld/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gretel-jsonld"
  s.version     = Gretel::Jsonld::VERSION
  s.authors     = ["yasaichi"]
  s.email       = ["yasaichi@users.noreply.github.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Gretel::Jsonld."
  s.description = "TODO: Description of Gretel::Jsonld."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_development_dependency "sqlite3"
end
