require 'spec_helper'

describe Traktion do
  it 'has a version number' do
    expect(Traktion::VERSION).not_to be nil
  end

  it 'has an end point' do
    expect(Traktion::ENDPOINT).not_to be nil
  end

  it 'returns a Control instance when started' do
    control = Traktion.start('foobar')
    expect(control).to be_a(Traktion::Control)
  end

  it 'has to be started with an API key' do
    expect {Traktion.start}.to raise_error(ArgumentError)
  end

  it 'has an API instance once started' do
    Traktion.start('foobar')
    expect(Traktion.api).to be_a(Her::API)
  end
end
