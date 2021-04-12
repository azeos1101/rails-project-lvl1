require_relative 'lib/form_gen/version'

Gem::Specification.new do |spec|
  spec.name          = 'azeos-form-gen-lvl1'
  spec.version       = FormGen::VERSION
  spec.authors       = ['Dmitriy Pavlenko']
  spec.email         = ['azeos1101@ya.ru']

  spec.summary       = 'Hexlet Rails study poject. lvl1'
  spec.description   = 'First study project for Ruby on Rails'
  spec.homepage      = 'https://github.com/azeos1101/rails-project-lvl1'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
