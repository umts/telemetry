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

    context 'with no repository configured' do
      it 'signifies the app is unknown in the subject' do
        expect(call.subject).to include('unknown app')
      end
    end

    context 'with a repository configured' do
      before { allow(UMTS::Telemetry).to receive(:repository).and_return('my-app') }

      it 'has the repository in the subject' do
        expect(call.subject).to include('my-app')
      end
    end
  end
end
