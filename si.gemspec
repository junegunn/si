# -*- encoding: utf-8 -*-
require File.expand_path('../lib/si/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Junegunn Choi"]
  gem.email         = ["junegunn.c@gmail.com"]
  gem.description   = %q{Formats a number with SI prefix}
  gem.summary       = %q{Formats a number with SI prefix (metric prefix)}
  gem.homepage      = "https://github.com/junegunn/si"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "si"
  gem.require_paths = ["lib"]
  gem.version       = SI::VERSION
end
