# Sinatra

An error mailer and logger are provided to sinatra apps.

The logger will write to the file `log/#{RACK_ENV}.log`, relative to your app root.

```ruby
class YourApp < Sinatra::Base
  register UMTS::Telemetry::Sinatra::ErrorMailer
  register UMTS::Telemetry::Sinatra::Logger

  # if you are somewhere like lib/your_app.rb
  set :root, Pathname(__dir__).join("..")
end
```
