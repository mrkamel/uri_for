# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "uri_for/version"

Gem::Specification.new do |s| 
  s.name        = "uri_for"
  s.version     = UriFor::VERSION
  s.authors     = ["Benjamin Vetter"]
  s.email       = ["vetter@flakks.com"]
  s.summary     = %q{Build smart URIs from hashes in your rails code}
  s.description = %q{Build smart URIs from hashes in your rails code}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_dependency "rails", "~> 2.3"
end

