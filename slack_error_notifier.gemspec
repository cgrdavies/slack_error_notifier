# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_error_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "slack_error_notifier"
  spec.version       = SlackErrorNotifier::VERSION
  spec.authors       = ["Chris Davies"]
  spec.email         = ["cdavies@salsify.com"]

  spec.summary       = %q{Sends exceptions to a slack channel or user.}
  spec.description   = %q{Wrap your code in our block and let us send error messages when you screw up. }
  spec.homepage      = "https://github.com/cgrdavies/slack_error_notifier"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"

  s.add_runtime_dependency "slack-ruby-client"
end
