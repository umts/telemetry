# frozen_string_literal: true

require 'rack/test'
require 'sinatra/base'

RSpec.describe UMTS::Telemetry::Sinatra do
  include Rack::Test::Methods

  let(:tmp) { Dir.mktmpdir }
  let(:app) do
    root = tmp
    Class.new(Sinatra::Base) do
      register UMTS::Telemetry::Sinatra

      set :root, root
      set :environment, :fake_environment

      get '/' do
        200
      end

      get '/error' do
        raise 'uh oh'
      end
    end
  end

  before { allow(UMTS::Telemetry).to receive(:error!).and_return(nil) }
  after { FileUtils.remove_entry(tmp) }

  it 'enables logging' do
    expect(app.settings).to be_logging
  end

  it 'opens a log file' do
    get '/'
    get '/'
    expect(last_request.env['rack.errors']).to be_a(File).and have_attributes(
      path: Pathname(tmp).join('log/fake_environment.log').to_s,
      sync: true
    )
  end

  it 'reports errors' do
    get '/error'
  rescue StandardError
    expect(UMTS::Telemetry).to have_received(:error!).with(
      instance_of(RuntimeError).and(having_attributes(message: 'uh oh'))
    )
  end
end
