# frozen_string_literal: true

require_relative 'telemetry/error_mail'
require_relative 'telemetry/sinatra'
require_relative 'telemetry/version'

module UMTS
  module Telemetry
    class << self
      attr_accessor :repository

      def filter_parameters
        %i[passw email secret token _key crypt salt certificate otp ssn cvv cvc github]
      end

      def error!(error, context: {})
        return unless ENV['RACK_ENV'] == 'production'

        ErrorMail.new(error, context:).deliver!
      end
    end
  end
end
