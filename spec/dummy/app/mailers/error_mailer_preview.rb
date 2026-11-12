# frozen_string_literal: true

class ErrorMailerPreview < ActionMailer::Preview
  def mail
    error = begin
      raise 'Some error'
    rescue StandardError => e
      e
    end
    UMTS::Telemetry::ErrorMail.new(error)
  end
end
