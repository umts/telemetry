# frozen_string_literal: true

require_relative 'telemetry/sinatra'
require_relative 'telemetry/version'

module UMTS
  module Telemetry
    class << self
      def error!(_) = nil
    end
  end
end
