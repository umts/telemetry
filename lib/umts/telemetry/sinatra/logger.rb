# frozen_string_literal: true

module UMTS
  module Telemetry
    module Sinatra
      module Logger
        class << self
          def registered(app)
            memo = memoized_log_file(app)
            app.enable :logging
            app.before { env['rack.errors'] = memo.call }
          end

          private

          def memoized_log_file(app)
            file = nil
            lambda do
              file ||= Pathname(app.settings.root).join('log')
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
end
