# FakePin

TODO: Write a gem description

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
  if Rails.env.development? || Rails.env.test?
    constraints :host => /pin.your-app.dev/ do
      mount FakePin::Rack.new => '/'
    end
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
