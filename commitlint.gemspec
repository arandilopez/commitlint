# frozen_string_literal: true

require_relative "lib/commitlint/version"

Gem::Specification.new do |spec|
  spec.name = "commitlint"
  spec.version = Commitlint::VERSION
  spec.authors = ["Arandi Lopez"]
  spec.email = ["arandilopez.93@gmail.com"]

  spec.summary = "Conventional commint linter for Ruby projects"
  spec.description = "Lint your commit messages to ensure they follow the conventional commit format."
  spec.homepage = "https://github.com/arandilopez/commitlint"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "optparse"
end
