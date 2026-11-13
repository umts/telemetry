# frozen_string_literal: true

class ErrorMailerPreview < ActionMailer::Preview
  def mail
    error = begin
      raise 'Some error'
    rescue StandardError => e
      e
    end
    context = { 'Context 1' => { 'Key 1' => 'Value 1', 'Key 2' => 'Value 2' },
                'Context 2' => { 'Key 1' => 'Value 1', 'Key 2' => 'Value 2' } }
    UMTS::Telemetry::ErrorMail.new(error, context:)
  end
end
