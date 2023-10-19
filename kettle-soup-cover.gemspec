# frozen_string_literal: true

# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-825171399
load "lib/kettle/soup/cover/version.rb"
gem_version = Kettle::Soup::Cover::Version::VERSION
Kettle::Soup::Cover::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "kettle-soup-cover"
  spec.version = gem_version
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  # See CONTRIBUTING.md
  spec.cert_chain = ["certs/pboling.pem"]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  spec.summary = "A Covered Kettle of SOUP, A Bundler Plugin"
  spec.description = <<~DESC
    A Covered Kettle of Test Coverage SOUP (Software of Unknown Provenance)
    Four-line SimpleCov config, w/ curated, opinionated, pre-configured, dependencies
  DESC
  spec.homepage = "https://gitlab.com/rubocop-lts/#{spec.name}"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata["homepage_uri"] = "https://#{spec.name}.gitlab.io/"
  spec.metadata["source_code_uri"] = "#{spec.homepage}/-/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/-/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/-/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/-/wiki"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the spec.add_dependency(when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*.rb",
    "sig/**/*.rbs",
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "plugins.rb",
    "README.md",
    "SECURITY.md",
  ]
  spec.bindir = "exe"
  spec.executables = []
  spec.require_paths = ["lib"]

  # Utilities
  spec.add_dependency("version_gem", "~> 1.1", ">= 1.1.3")
  spec.add_development_dependency("rake", "~> 13.0")

  # Code Coverage
  # CodeCov + GitHub setup is not via gems: https://github.com/marketplace/actions/codecov
  spec.add_dependency("simplecov", "~> 0.22") # Includes dependency on simplecov-html
  spec.add_dependency("simplecov-cobertura", "~> 2.1") # Jenkins compatibility (XML)
  spec.add_dependency("simplecov-console", "~> 0.9", ">= 0.9.1") # TTY / Console output
  spec.add_dependency("simplecov-html", "~> 0.12") # Human compatibility! (HTML)
  spec.add_dependency("simplecov_json_formatter", "~> 0.1", ">= 0.1.4") # CodeClimate compatibility (JSON)
  spec.add_dependency("simplecov-lcov", "~> 0.8") # GCOV compatibility
  spec.add_dependency("simplecov-rcov", "~> 0.3", ">= 0.3.3") # Hudson compatibility

  # Documentation
  spec.add_development_dependency("kramdown", "~> 2.4")
  spec.add_development_dependency("yard", "~> 0.9", ">= 0.9.34")
  spec.add_development_dependency("yard-junk", "~> 0.0")

  # Linting
  spec.add_development_dependency("rubocop-lts", "~> 18.1", ">= 18.2.1") # Lint & Style Support for Ruby 2.7+
  spec.add_development_dependency("rubocop-packaging", "~> 0.5", ">= 0.5.2")
  spec.add_development_dependency("rubocop-rspec", "~> 2.24")

  # Testing
  spec.add_development_dependency("rspec", "~> 3.12")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.5")
  spec.add_development_dependency("rspec_junit_formatter", "~> 0.6")
  spec.add_development_dependency("rspec-stubbed_env", "~> 1.0", ">= 1.0.1")
end
