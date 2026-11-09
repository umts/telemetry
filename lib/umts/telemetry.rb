# frozen_string_literal: true

require_relative 'telemetry/sinatra'
require_relative 'telemetry/version'

module UMTS
  module Telemetry
    class << self
      # simplecov:disable
      def error!(_) = nil
      # simplecov:enable
    end
  end
end
