# frozen_string_literal: true

require 'mail'

module UMTS
  module Telemetry
    class ErrorMail < Mail::Message
      TEMPLATE = File.expand_path('error_mail.html.erb', __dir__)

      def initialize(error)
        @error = error
        html = render
        super do
          from 'transportation-it@admin.umass.edu'
          to 'programmers@admin.umass.edu'
          subject "#{@error.class} from gtfs-cache"
          content_type 'text/html; charset=UTF-8'
          body html
        end
      end

      private

      def render
        ERB.new(File.read(TEMPLATE)).result(binding)
      end
    end
  end
end
