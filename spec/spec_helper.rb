$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'traktion'
require 'json'

RSpec.configure do |c|
  c.include(Module.new do
    def stub_api_for(klass)
      klass.use_api (api = Her::API.new)

      api.setup(url: "https://api-v2launch.trakt.tv") do |c|
        c.use Her::Middleware::FirstLevelParseJSON
        c.adapter(:test) {|s| yield(s)}
      end
    end
  end)
end
