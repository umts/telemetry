# frozen_string_literal: true

require 'rack/test'
require 'sinatra/base'

RSpec.describe UMTS::Telemetry::Sinatra::ErrorMailer do
  include Rack::Test::Methods

  let(:app) do
    Class.new(Sinatra::Base) do
      set :environment, :test
      set :raise_errors, false
      register UMTS::Telemetry::Sinatra::ErrorMailer

      get '/' do
        raise 'uh oh'
      end
    end
  end

  before { allow(UMTS::Telemetry).to receive(:error!).and_return(nil) }

  it 'reports errors' do
    get '/'
  rescue StandardError
    expect(UMTS::Telemetry).to have_received(:error!).with(
      instance_of(RuntimeError).and(having_attributes(message: 'uh oh'))
    )
  end
end
