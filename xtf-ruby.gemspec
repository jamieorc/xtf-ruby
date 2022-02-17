# frozen_string_literal: true

require_relative "lib/xtf/ruby/version"

Gem::Specification.new do |s|
  s.name = "xtf-ruby"
  s.version = XTF::Ruby::VERSION
  s.authors = ["James (Jamie) Orchard-Hays"]
  s.email = ["jamieorc@gmail.com"]

  s.summary = "Ruby library for working with California Digital Library's XTF."
  # s.description = "TODO: Write a longer description or delete this line."
  s.homepage = "https://github.com/jamieorc/xtf-ruby"
  s.license = "Apache-2.0"
  s.required_ruby_version = ">= 2.6.0"

  # s.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/jamieorc/xtf-ruby"
  s.metadata["changelog_uri"] = "https://github.com/jamieorc/xtf-ruby/blob/v#{version}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  s.bindir = "exe"
  s.executables = s.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "libxml-ruby", "~> 3.2"
  s.add_dependency "activesupport"

  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rexml", "~> 3.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
