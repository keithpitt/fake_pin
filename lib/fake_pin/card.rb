module FakePin
  class Card
    class UnrecognisedCardSchemeError < RuntimeError; end

    REQUIRED_PARAMS = :number, :expiry_month, :expiry_year, :name
    REQUIRED_ADDRESS_PARAMS = :address_line1, :address_city, :address_postcode, :address_state, :address_country

    SCHEMES = {
      'visa'               => /^4\d{12}(\d{3})?$/,
      'master'             => /^(5[1-5]\d{4}|677189)\d{10}$/,
      'discover'           => /^(6011|65\d{2}|64[4-9]\d)\d{12}|(62\d{14})$/,
      'american_express'   => /^3[47]\d{13}$/,
      'diners_club'        => /^3(0[0-5]|[68]\d)\d{11}$/,
      'jcb'                => /^35(28|29|[3-8]\d)\d{12}$/,
      'switch'             => /^6759\d{12}(\d{2,3})?$/,
      'solo'               => /^6767\d{12}(\d{2,3})?$/,
      'dankort'            => /^5019\d{12}$/,
      'maestro'            => /^(5[06-8]|6\d)\d{10,17}$/,
      'forbrugsforeningen' => /^600722\d{10}$/,
      'laser'              => /^(6304|6706|6709|6771(?!89))\d{8}(\d{4}|\d{6,7})?$/
    }

    def self.create(params)
      new(params).create
    end

    def initialize(params)
      @params = params
    end

    def create
      required_params = if FakePin.configuration.require_address
                          [ *REQUIRED_PARAMS, *REQUIRED_ADDRESS_PARAMS ]
                        else
                          REQUIRED_PARAMS
                        end

      @params.require(*required_params)

      number = @params['number'].to_s.gsub(/[^0-9]+/, '')

      {
        "token"            => Token.generate('card'),
        "display_number"   => obfuscate_card_number(number),
        "expiry_month"     => @params['expiry_month'],
        "expiry_year"      => @params['expiry_year'],
        "name"             => @params['name'],
        "address_line1"    => @params['address_line1'],
        "address_line2"    => @params['address_line2'],
        "address_city"     => @params['address_city'],
        "address_postcode" => @params['address_postcode'],
        "address_state"    => @params['address_state'],
        "address_country"  => @params['address_country'],
        "scheme"           => card_scheme(number)
      }
    end

    private

    def card_scheme(number)
      SCHEMES.each_pair { |scheme, regex| return scheme if number =~ regex }

      raise UnrecognisedCardSchemeError
    end

    def obfuscate_card_number(card_number)
      "XXXX-XXXX-XXXX-#{card_number[-4..-1]}"
    end
  end
end
