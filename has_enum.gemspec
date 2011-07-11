# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_enum/version"

Gem::Specification.new do |s|
  s.name        = "has_enum"
  s.version     = HasEnum::VERSION
  s.authors     = ["Dirk Breuer, Alexander Gräfe and Ethem Küçük"]
  s.email       = ["dev@pkw.de"]
  s.summary     = %q{The has_enum extension provides an association with an enumeration class which requires the renum gem}
  s.description = %q{The has_enum extension provides an association with an enumeration class which requires the renum gem}
  
  s.add_dependency "renum", ">= 1.3.1"
  s.add_dependency "activerecord"
  
  s.add_development_dependency "test-unit"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
