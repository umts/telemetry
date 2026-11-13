# frozen_string_literal: true

require 'mail'

module UMTS
  module Telemetry
    class ErrorMail < Mail::Message
      TEMPLATE = File.expand_path('error_mail.html.erb', __dir__)

      def initialize(error, context: {}) # rubocop:disable Metrics/MethodLength
        @error = error
        @context = context
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

      def trimmed_backtrace
        @error.backtrace
              &.map { |line| line.delete_prefix(Dir.pwd).delete_prefix(Gem.dir).delete_prefix('/') }
              &.join("\n")
      end

      def sanitize(context)
        context.reject { |key, _| Telemetry.filter_parameters.any? { |pattern| key.to_s.include?(pattern.to_s) } }
      end
    end
  end
end
