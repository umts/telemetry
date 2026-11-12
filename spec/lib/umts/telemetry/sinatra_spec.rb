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

  context 'when running in production' do
    let(:mail) { instance_double(UMTS::Telemetry::ErrorMail) }

    before do
      stub_const('ENV', ENV.to_hash.merge('RACK_ENV' => 'production'))
      allow(UMTS::Telemetry::ErrorMail).to receive(:new).and_return(mail)
      allow(mail).to receive(:deliver!).and_return(nil)
    end

    it 'reports errors' do
      get '/error'
    rescue StandardError
      expect(UMTS::Telemetry::Mail).to have_received(:new).with(
        instance_of(RuntimeError).and(having_attributes(message: 'uh oh'))
      )
    end
  end

  context 'when not running in production' do
    before { allow(UMTS::Telemetry::ErrorMail).to receive(:new).and_call_original }

    it 'does not report errors' do
      get '/error'
    rescue StandardError
      expect(UMTS::Telemetry::Mail).not_to have_received(:new)
    end
  end
end
