# frozen_string_literal: true

require 'mail'

module UMTS
  module Telemetry
    class ErrorMail < Mail::Message
      TEMPLATE = File.expand_path('error_mail.html.erb', __dir__)

      def initialize(error)
        @error = error
        error_subject = render_subject
        error_body = render_body
        super do
          from 'transportation-it@admin.umass.edu'
          to 'programmers@admin.umass.edu'
          subject error_subject
          content_type 'text/html; charset=UTF-8'
          body error_body
        end
      end

      private

      def render_subject = "#{@error.class} from #{Telemetry.repository || 'unknown app'}"

      def render_body
        ERB.new(File.read(TEMPLATE)).result(binding)
      end
    end
  end
end
