require "faraday"

module Traktion
  class ClientIdAuthenticator < Faraday::Middleware
    def initialize(client)
      @client = client
    end

    def call(env)
      headers = env[:request_headers]
      headers.merge(@client.HEADERS)
      @app.call(env)
    end
  end
end
