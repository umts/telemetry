# Sinatra

A simple logger implementation is provided for Sinatra apps.

It will write rack common logs to the file `log/#{RACK_ENV}.log`, relative to your app root.

```ruby
class YourApp < Sinatra::Base
  # if you are somewhere like lib/your_app.rb
  set :root, Pathname(__dir__).join("..")

  register UMTS::Telemetry::Sinatra::Logger
end
```
