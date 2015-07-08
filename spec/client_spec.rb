require 'spec_helper'

describe Traktion::Client do
  it 'can be instantiated with a client id' do
    client = Traktion::Client.new('foobar')
    expect(client).not_to be nil
    expect(client.client_id).to eq('foobar')
  end
end
