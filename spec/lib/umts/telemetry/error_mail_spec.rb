# frozen_string_literal: true

RSpec.describe UMTS::Telemetry::ErrorMail do
  describe '#initialize' do
    subject(:call) { described_class.new(error, context: { 'Context' => { 'Key' => 'Value' } }) }

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

    it 'has the error class in the body' do
      expect(call.body).to include('RuntimeError')
    end

    context 'with a backtrace' do
      it 'has the backtrace in the body' do
        lines = error.backtrace.map { |line| line.delete_prefix(Dir.pwd).delete_prefix(Gem.dir).delete_prefix('/') }
        expect(call.body).to include('RuntimeError', *lines)
      end
    end

    context 'without a backtrace' do
      let(:error) { RuntimeError.new('No backtrace') }

      it 'signifies no backtrace was given' do
        expect(call.body).to include('No backtrace given')
      end
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
