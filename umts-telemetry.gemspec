# frozen_string_literal: true

require_relative 'lib/umts/telemetry/version'

Gem::Specification.new do |spec|
  spec.name = 'umts-telemetry'
  spec.version = UMTS::Telemetry::VERSION
  spec.authors = ['UMTS']
  spec.email = ['transportation-it@admin.umass.edu']
  spec.homepage = 'https://github.com/umts/telemetry'
  spec.summary = 'Telemetry for UMTS rails and sinatra apps.'
  spec.license = 'MIT'

  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/releases"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'LICENSE.md', 'README.md']
  end

  spec.required_ruby_version = '>= 3.3.0'
end
