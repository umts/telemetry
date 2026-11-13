# frozen_string_literal: true

class ErrorMailerPreview < ActionMailer::Preview
  def mail
    UMTS::Telemetry::ErrorMail.new(error, context: { 'Environment' => ActionDispatch::TestRequest.create.env })
  end

  private

  def error
    raise 'Some error'
  rescue StandardError => e
    e
  end
end
