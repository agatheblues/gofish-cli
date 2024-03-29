# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "go_fish"
  spec.version       = '1.0'
  spec.authors       = ["Agathe Lenclen"]
  spec.email         = ["youremail@yourdomain.com"]
  spec.summary       = %q{Short summary of your project}
  spec.description   = %q{Longer description of your project.}
  spec.homepage      = "http://domainforproject.com/"
  spec.license       = "MIT"

  spec.files         = ['lib/go_fish.rb']
  spec.executables   = ['bin/go_fish']
  spec.test_files    = ['tests/test_go_fish.rb']
  spec.require_paths = ["lib"]
end