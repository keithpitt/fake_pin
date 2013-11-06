module FakePin
  class Customer
    def self.create(params)
      new(params).create
    end

    def initialize(params)
      @params = params
    end

    def create
      card = @params['card']
      @params.require(:email, :card => Card::REQUIRED_PARAMS) if card.present?

      response =  { "token"      => Token.generate('cus'),
                    "email"      => @params['email'],
                    "created_at" => Time.now.to_s }

      response['card'] = Card.create(card) if card.present?

      response
    end
  end
end
