# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jcblog/version"

Gem::Specification.new do |s|
  s.name        = "jcblog"
  s.version     = Jcblog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John C. Burr"]
  s.email       = ["johncburr@gmail.com"]
  s.summary     = %q{A very basic blog site gem}
  s.description = %q{Intended to become an easy-yet-reasonably-robust add-on for other rails sites.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # dependencies
  s.add_dependency 'rails', '3.0.7'
  s.add_dependency 'sqlite3-ruby', '1.3.2'
  s.add_dependency 'bcrypt-ruby', '>= 2.1.4'

  # development dependencies
  s.add_development_dependency 'rspec-rails', '>= 2.5.0'
  s.add_development_dependency 'annotate-models', '>= 1.0.4'
  s.add_development_dependency 'shoulda', '>= 2.11.3'
  s.add_development_dependency 'mocha', '>= 0.9.8'
  s.add_development_dependency 'factory_girl_rails', '>= 1.0.0'
  s.add_development_dependency 'autotest', '>= 4.4.6'
  s.add_development_dependency 'rcov', '>= 0.9.9'
  s.add_development_dependency 'metrical', '>= 0.0.5'
end
