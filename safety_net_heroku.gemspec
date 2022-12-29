
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "safety_net_heroku/version"

Gem::Specification.new do |spec|
  spec.name          = "safety_net_heroku"
  spec.version       = SafetyNetHeroku::VERSION
  spec.authors       = ["daltron"]
  spec.email         = ["daltonhint4@gmail.com"]

  spec.summary       = "A simple gem for backing up a MongoDB database to AWS when hosted on Heroku using a Sidekiq worker."
  spec.homepage      = "https://github.com/daltron/safety_net_heroku"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir['lib/*.rb', 'lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'aws-sdk-s3', '~> 1.48.0'
  spec.add_dependency 'sidekiq', '~> 6.5.5'
end
