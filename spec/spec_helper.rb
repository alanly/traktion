$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'traktion'
require 'traktion/models/base'
require 'json'

RSpec.configure do |c|
  c.include(Module.new do
    def stub_api_for(klass)
      klass.use_api (api = Her::API.new)

      api.setup(url: "https://api-v2launch.trakt.tv") do |c|
        c.use Traktion::Middleware::ApiKeyAuthenticator, :api_key => 'foobarbaz'
        c.use Faraday::Request::UrlEncoded
        c.use Her::Middleware::DefaultParseJSON
        c.adapter(:test) {|s| yield(s)}
      end
    end
  end)
end
