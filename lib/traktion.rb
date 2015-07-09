require "her"

require "traktion/version"
require "traktion/middleware/api_key_authenticator"

module Traktion
  ENDPOINT = "http://api-v2launch.trakt.tv/"

  def self.api
    @api
  end

  def self.start(api_key)
    @api = Her::API.new
    @api.setup(url: Traktion::ENDPOINT) do |c|
      # Request Middleware
      c.use Traktion::Middleware::ApiKeyAuthenticator, :api_key => api_key
      c.use Faraday::Request::UrlEncoded

      # Response Middleware
      c.use Her::Middleware::DefaultParseJSON

      # Adapter
      c.use Faraday::Adapter::NetHttp
    end

    # Create the client instance.
    require 'traktion/control'
    Traktion::Control.new
  end
end
