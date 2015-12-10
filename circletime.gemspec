lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'circletime/version'

Gem::Specification.new do |spec|
  spec.name          = "circletime"
  spec.version       = Circletime::VERSION
  spec.authors       = ["yutakakinjyo"]
  spec.email         = ["yutakakinjyo@gmail.com"]

  spec.summary       = %q{ CircleTime get amount of build time from organization on CircleCI. }
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/yutakakinjyo/circletime"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'circleci'
  spec.add_runtime_dependency 'dotenv'
  spec.add_runtime_dependency 'activesupport'
 
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
end
