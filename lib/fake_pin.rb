module FakePin
  autoload :Card,          "fake_pin/card"
  autoload :Charge,        "fake_pin/charge"
  autoload :Customer,      "fake_pin/customer"
  autoload :Configuration, "fake_pin/configuration"
  autoload :Params,        "fake_pin/params"
  autoload :Rack,          "fake_pin/rack"
  autoload :Token,         "fake_pin/token"
  autoload :VERSION,       "fake_pin/version"

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    yield(configuration)
  end
end
