$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nice/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nice"
  s.version     = Nice::VERSION
  s.authors     = ["Benjamin Mueller"]
  s.email       = ["elchbenny@googlemail.com"]
  s.homepage    = ""
  s.summary     = "Nice / Nizza is a posh little town in south France."
  s.description = "Seriously, it's a nice little state engine for JS/HTML5 on Rails"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency "nokogiri"

  s.add_development_dependency "sqlite3"
end
