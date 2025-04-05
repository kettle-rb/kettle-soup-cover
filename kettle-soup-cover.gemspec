# frozen_string_literal: true

# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358
# Kernel.load because load is overloaded in RubyGems during gemspec evaluation
Kernel.load("lib/kettle/soup/cover/version.rb")
gem_version = Kettle::Soup::Cover::Version::VERSION
Kettle::Soup::Cover::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "kettle-soup-cover"
  spec.version = gem_version
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  # Linux distros may package ruby gems differently,
  #   and securely certify them independently via alternate package management systems.
  # Ref: https://gitlab.com/oauth-xx/version_gem/-/issues/3
  # Hence, only enable signing if the cert_file is present.
  # See CONTRIBUTING.md
  default_user_cert = "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem"
  default_user_cert_path = File.join(__dir__, default_user_cert)
  cert_file_path = ENV.fetch("GEM_CERT_PATH", default_user_cert_path)
  cert_chain = cert_file_path.split(",")
  if cert_file_path && cert_chain.map { |fp| File.exist?(fp) }
    spec.cert_chain = cert_chain
    if $PROGRAM_NAME.end_with?("gem", "rake") && ARGV[0] == "build"
      spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem")
    end
  end

  spec.summary = "A Covered Kettle of SOUP, A Code Coverage Meta Gem"
  spec.description = <<~DESC
    A Covered Kettle of Test Coverage SOUP (Software of Unknown Provenance)
    Four-line SimpleCov config, w/ curated, opinionated, pre-configured, dependencies
  DESC
  spec.homepage = "https://gitlab.com/kettle-rb/#{spec.name}"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata["homepage_uri"] = "https://kettle-rb.gitlab.io/"
  spec.metadata["source_code_uri"] = "#{spec.homepage}/-/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/-/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/-/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/-/wiki"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*.rb",
    "lib/**/rakelib/*.rake",
    "sig/**/*.rbs",
  ]
  # Automatically included with gem package, no need to list again in files.
  spec.extra_rdoc_files = Dir[
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
  ]
  spec.rdoc_options += [
    "--title",
    "#{spec.name} - #{spec.summary}",
    "--main",
    "README.md",
    "--line-numbers",
    "--inline-source",
    "--quiet",
  ]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"
  spec.executables = []

  # Utilities
  spec.add_dependency("version_gem", "~> 1.1", ">= 1.1.6")

  # Release Tasks
  spec.add_development_dependency("rake", "~> 13.0")
  spec.add_development_dependency("stone_checksums", "~> 1.0")

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
  spec.add_development_dependency("yard", "~> 0.9", ">= 0.9.37")
  spec.add_development_dependency("yard-junk", "~> 0.0", ">= 0.0.10")

  # Linting
  # RuboCop is constrained due to major changes newer RuboCop, and the team's disinterest in SemVer
  spec.add_development_dependency("rubocop-lts", "~> 18.1", ">= 18.2.1") # Lint & Style Support for Ruby 2.7+
  spec.add_development_dependency("rubocop-packaging", "~> 0.6", ">= 0.6.0")
  spec.add_development_dependency("rubocop-rspec", "~> 3.5")

  # Testing
  spec.add_development_dependency("rspec", "~> 3.13")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.5")
  spec.add_development_dependency("rspec_junit_formatter", "~> 0.6")
  spec.add_development_dependency("rspec-stubbed_env", "~> 1.0", ">= 1.0.1")
end
