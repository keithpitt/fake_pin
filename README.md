# FakePin

A basic implmentation of the Pin Payments REST API. This is great for when you want to test your API client or want an offline version of the API for automated testing.

**Note: The whole API isn't supported yet. Only adding cards, charging cards, and adding customers works currently. If you want one of the other API endpoints supported, Pull Requests are welcome, or just create an issue and I'll do it ASAP**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fake_pin'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install fake_pin
```

## Usage

In your Rails Routes folder:

```ruby
YourApp::Application.routes.draw do
  # ...

  if Rails.env.development? || Rails.env.test?
    constraints :host => /pin.your-app.dev/ do
      mount FakePin::Rack.new => '/'
    end
  end
end
```

Or you can run it as a standlone server. Currently it only support WEBrick and runs on port 9000.

```bash
$ fake_pin
```

You should then be able to cURL charges like so:

```bash
curl localhost:9000/1/charges -u your-secret-api-key: -d "amount=400" -d "currency=AUD" -d "description=test charge" -d "email=roland@pin.net.au" -d "ip_address=203.192.1.172" -d "card[number]=5520000000000000" -d "card[expiry_month]=05" -d "card[expiry_year]=2014" -d "card[cvc]=123" -d "card[name]=Roland Robot" -d "card[address_line1]=42 Sevenoaks St" -d "card[address_line2]=" -d "card[address_city]=Lathlain" -d "card[address_postcode]=6454" -d "card[address_state]=WA" -d "card[address_country]=Australia"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
