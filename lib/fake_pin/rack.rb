require 'json'
require 'rack'

module FakePin
  class Rack
    def call(env)
      request = ::Rack::Request.new(env)
      method  = env['REQUEST_METHOD']
      path    = env['PATH_INFO']

      # Strip the first slash if there is one. When mounted in Rails, there is no slash.
      # When running as a standlone rack app, there is one.
      path = path.gsub(/\A\//, '')

      params  = if env['CONTENT_TYPE'] == "application/json"
                  Params.new(JSON.parse(request.body.read))
                else
                  Params.new(request.params)
                end

      jsonp = (method == "GET" && params['_method'] == "POST")
      jsonp_callback = jsonp ? params['callback'] : nil

      if path == "1/customers"
        if method == "POST"
          return render_response(201, Customer.create(params))
        end
      elsif path == "1/charges"
        if method == "POST"
          return render_response(201, Charge.create(params))
        end
      elsif path =~ /1\/cards(\.json)?/
        if method == "POST" || jsonp
          return render_response(201, Card.create(params), :callback => jsonp_callback)
        end
      end

      render_404
    rescue Params::MissingParametersError => e
      messages = e.parameters.map do |param|
        { :code => "#{param}_invalid", :message => "#{param} is required", :param => param }
      end

      render_error 422, 'invalid_resource', 'One or more parameters were missing or invalid.', messages, :callback => jsonp_callback
    rescue => e
      render_error 500, 'fake_pin_exception', "FakePin broke with: #{e.class.name}:#{e.message}", nil, :callback => jsonp_callback
    end

    private

    def render_404
      render_error(404, "invalid_resource", "The resource you requested could not be found", nil, :callback => jsonp_callback)
    end

    def render_error(status, error, description, messages = nil, options = {})
      response = { :error => error, :error_description => description }
      response[:messages] = messages unless messages.nil?

      render_response(status, response, options)
    end

    def render_response(status, response, options = {})
      if options[:callback]
        render_jsonp(status, { :response => response }, options[:callback])
      else
        render_json(status, :response => response)
      end
    end

    def render_jsonp(status, json, callback)
      [
        status,
        {"Content-Type" => 'text/javascript'},
        ["#{callback}(#{JSON.dump(json)})"]
      ]
    end

    def render_json(status, json)
      [
        status,
        {"Content-Type" => 'text/json'},
        [JSON.dump(json)]
      ]
    end
  end
end
