# frozen_string_literal: true

module UMTS
  module Telemetry
    module Sinatra
      class << self
        def registered(app)
          app.use ErrorMailer
          app.enable :logging
          app.set :log_file, nil
          app.before do
            settings.set(:log_file, UMTS::Telemetry::Sinatra.log_file(settings)) unless settings.log_file
            env['rack.errors'] = settings.log_file
          end
        end

        def log_file(settings)
          Pathname(settings.root).expand_path
                                 .join('log')
                                 .tap(&:mkpath)
                                 .join("#{settings.environment}.log")
                                 .open('a+')
                                 .tap { |file| file.sync = true }
        end
      end

      class ErrorMailer
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
