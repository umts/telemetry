# frozen_string_literal: true

require 'fakefs/safe'
require 'rack/test'
require 'sinatra/base'

RSpec.describe UMTS::Telemetry::Sinatra::Logger do
  include Rack::Test::Methods

  around { |example| FakeFS { example.run } }

  let(:app) do
    Class.new(Sinatra::Base) do
      register UMTS::Telemetry::Sinatra::Logger

      set :root, '/fake/root'
      set :environment, :fake_environment

      get('/') { 200 }
    end
  end

  it 'enables logging' do
    expect(app.settings).to be_logging
  end

  it 'opens a log file' do
    get '/'
    expect(last_request.env['rack.errors']).to be_a(File).and have_attributes(
      path: '/fake/root/log/fake_environment.log',
      sync: true
    )
  end
end
