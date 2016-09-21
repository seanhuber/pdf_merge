$:.push File.expand_path('../lib', __FILE__)

require 'pdf_merge/version'

Gem::Specification.new do |s|
  s.name          = 'pdf_merge'
  s.version       = PdfMerge::VERSION
  s.authors       = ['Sean Huber']
  s.email         = ['seanhuber@seanhuber.com']
  s.homepage      = 'https://github.com/seanhuber/pdf_merge'
  s.summary       = 'Mountable Rails engine that provides functionality of browsing PDFs and merging pages accross files'
  s.license       = 'MIT'
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ['lib']
  s.test_files    = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 5.0.0', '>= 5.0.0.1'

  s.add_dependency 'rsync_wrapper', '~> 1.0.0'
  s.add_dependency 'doc_2_pdf', '~> 1.1.0'
  s.add_dependency 'pdf_thumbnailer', '~> 1.2.0'
  s.add_dependency 'fastimage'
  s.add_dependency 'combine_pdf', '~> 0.2'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'awesome_print'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'rack_session_access'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'pry-byebug'
end
