# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bitten/version', __FILE__)

Gem::Specification.new do |s|
  # Metadata
  s.name        = 'bitten'
  s.version     = Bitten::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Arjan van der Gaag']
  s.email       = %q{arjan@arjanvandergaag.nl}
  s.description = %q{A simple implementation of a bit fields attribute for Ruby objects.}
  s.homepage    = %q{http://avdgaag.github.com/bitten}
  s.summary     = <<-EOS
Bitten is a simple module for adding multiple boolean flags to any Ruby object,
that internally get stored as a single integer attribute. If your Ruby object
is an ActiveRecord object, it also provides some convenience scopes for you.

The advantage is a simple data model, with a single attribute containing many
bits of information. You can keep adding more flags to the list of tracked
flags, as long as the order of existing flags is kept intact.
EOS

  # Files
  s.files         = `git ls-files`.split("
")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("
")
  s.executables   = `git ls-files -- bin/*`.split("
").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Rdoc
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = [
     'LICENSE',
     'README.md',
     'HISTORY.md'
  ]

  # Dependencies
  s.add_development_dependency 'kramdown'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'
end
