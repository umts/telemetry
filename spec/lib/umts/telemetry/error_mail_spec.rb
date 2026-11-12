# frozen_string_literal: true

RSpec.describe UMTS::Telemetry::ErrorMail do
  describe '#initialize' do
    subject(:call) do
      described_class.new(error)
    end

    let(:error) do
      raise 'Test error'
    rescue StandardError => e
      e
    end

    it 'is from transportation it' do
      expect(call.from).to eq(['transportation-it@admin.umass.edu'])
    end

    it 'is to programmers' do
      expect(call.to).to eq(['programmers@admin.umass.edu'])
    end

    it 'has the error class in the subject' do
      expect(call.subject).to include('RuntimeError')
    end

    it 'has the error class and backtrace in the body' do
      expect(call.body).to include('RuntimeError', *error.backtrace)
    end
  end
end
