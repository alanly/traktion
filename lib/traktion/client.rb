module Traktion
  class Client
    attr_accessor :client_id

    HEADERS = {
      'Content-type'      => 'application/json',
      'trakt-api-key'     => @client_id,
      'trakt-api-version' => '2',
    }

    OPTIONS = {
      :scheme   => 'https',
      :endpoint => 'api-v2launch.trakt.tv',
      :ssl      => {verify: false},
    }

    def initialize(client_id)
      @client_id = client_id
      setup_her
    end

    private

    def setup_her
      url = get_url
      authenticator = get_authenticator

      Her::API.setup(url: url, ssl: OPTIONS[:ssl]) do |c|
        # Request Middleware
        c.use authenticator
        c.use Faraday::Request::UrlEncoded

        # Response Middleware
        c.use Her::Middleware::DefaultParseJSON

        # Adapter
        c.use Faraday::Adapter::NetHttp
      end
    end

    def get_authenticator
      Traktion::ClientIdAuthenticator.new(self)
    end

    def get_url
      "#{OPTIONS[:scheme]}://#{OPTIONS[:endpoint]}"
    end
  end
end

require "traktion/models/base"
require "traktion/models/show"
