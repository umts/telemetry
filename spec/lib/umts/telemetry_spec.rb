# frozen_string_literal: true

require 'umts/telemetry'

RSpec.describe UMTS::Telemetry do
  it 'has a version' do
    expect(UMTS::Telemetry::VERSION).not_to be_nil
  end
end
