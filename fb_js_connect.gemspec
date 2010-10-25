# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fb_js_connect/version"

Gem::Specification.new do |s|
  s.name        = "fb_js_connect"
  s.version     = FbJsConnect::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aaron Van Bokhoven"]
  s.email       = ["bokhoven@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/fb_js_connect"
  s.summary     = %q{fb_js_connect interfaces with the cookie that Facebook Connect Javascript SDK provides.}
  s.description = %q{fb_js_connect interfaces with the cookie that Facebook Connect Javascript SDK provides.}

  s.rubyforge_project = "fb_js_connect"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
