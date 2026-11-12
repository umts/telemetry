# Sinatra

An error mailer and logger are provided to sinatra apps.

The logger will write to the file `log/#{RACK_ENV}.log`, relative to your app root.

The error mailer will send error details to `programmers@admin.umass.edu`.

```ruby
# in root level environment file

UMTS::Telemetry.repository = 'your-app'
```

```ruby
class YourApp < Sinatra::Base
  register UMTS::Telemetry::Sinatra

  # if you are somewhere like lib/your_app.rb
  set :root, Pathname(__dir__).join("..")
end
```
