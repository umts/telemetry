# frozen_string_literal: true

module UMTS
  module Telemetry
    module Sinatra
      module ErrorMailer
        def self.registered(app) = app.use(Middleware)

        class Middleware
          def initialize(app)
            @app = app
          end

          def call(env)
            @app.call(env).tap { env['sinatra.error']&.then { |error| Telemetry.error!(error) } }
          end
        end
      end
    end
  end
end
