module FakePin
  class Charge
    def self.create(params)
      new(params).create
    end

    def initialize(params)
      @params = params
    end

    def create
      @params.require(:amount, :description)
      currency = @params["currency"] || "AUD"

      { "token"                 => Token.generate('ch'),
        "success"               => true,
        "amount"                => @params['amount'],
        "description"           => @params['description'],
        "currency"              => currency,
        "ip_address"            => "203.192.1.172",
        "email"                 => @params['email'],
        "status_message"        => "Success!",
        "error_message"         => nil,
        "captured"              => true,
        "authorisation_expired" => false,
        "transfer"              => nil,
        "created_at"            => Time.now.to_s }
    end
  end
end
