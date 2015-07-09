module Traktion
  module Middleware
    class ApiKeyAuthenticator < Faraday::Middleware
      def initialize(app, options={})
        @app = app
        @options = options
      end

      def call(env)
        env[:request_headers].merge!({
          'Content-type'      => 'application/json',
          'trakt-api-key'     => @options[:api_key],
          'trakt-api-version' => '2',
        })
        @app.call(env)
      end
    end
  end
end
