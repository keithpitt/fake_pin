module FakePin
  class Params
    class MissingParametersError < RuntimeError
      attr_reader :parameters

      def initialize(parameters, message = nil)
        @parameters = parameters
        super(message)
      end
    end

    def initialize(params)
      @params = params
    end

    def [](key)
      value = @params[key]
      if value.kind_of?(Hash)
        self.class.new(value)
      else
        value
      end
    end

    def require(*params)
      missing_params = []
      params.each do |param|
        if param.kind_of?(Hash)
          parent_key = param.keys.first
          param[parent_key].each do |child_key|
            if @params[parent_key.to_s][child_key.to_s].nil?
              missing_params << child_key
            end
          end
        else
          if @params[param.to_s].nil?
            missing_params << param
          end
        end
      end

      if missing_params.length > 0
        raise MissingParametersError.new(missing_params)
      end
    end
  end
end
