$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pdf_merge/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pdf_merge"
  s.version     = PdfMerge::VERSION
  s.authors     = ["Sean Huber"]
  s.email       = ["seanhuber@seanhuber.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of PdfMerge."
  s.description = "TODO: Description of PdfMerge."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
