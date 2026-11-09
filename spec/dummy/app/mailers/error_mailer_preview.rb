# frozen_string_literal: true

class ErrorMailerPreview < ActionMailer::Preview
  TEMPLATE = File.expand_path('../../../../lib/umts/mail.html.erb', __dir__)

  def mail
    html = ERB.new(File.read(TEMPLATE)).result(binding)
    ::Mail.new do
      from         'bobo@test.com'
      to           'bobo@test.com'
      subject      'test mail'
      content_type 'text/html; charset=UTF-8'
      body         html
    end
  end
end
