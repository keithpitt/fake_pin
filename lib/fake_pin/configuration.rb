module FakePin
  class Configuration
    attr_accessor :require_address

    def initialize
      @require_address = true
    end
  end
end
