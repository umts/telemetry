# frozen_string_literal: true

module UMTS
  module Telemetry
    module Sinatra
      module Logger
        class << self
          def registered(app)
            log_file = open_log_file!(app.settings.environment)
            app.enable :logging
            app.before { env['rack.errors'] = log_file }
          end

          private

          def open_log_file!(app)
            Pathname(app.settings.root).join('log')
                                       .expand_path
                                       .tap(&:mkpath)
                                       .join("#{app.settings.environment}.log")
                                       .open('a+')
                                       .tap { |file| file.sync = true }
          end
        end
      end
    end
  end
end
