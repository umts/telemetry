# frozen_string_literal: true

require_relative 'telemetry/error_mail'
require_relative 'telemetry/sinatra'
require_relative 'telemetry/version'

module UMTS
  module Telemetry
    class << self
      def error!(error)
        ErrorMail.new(error).deliver!
      end
    end
  end
end
