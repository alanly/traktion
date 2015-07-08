require 'spec_helper'

describe Traktion::Models::Show do
  before do
    # Stubs for Show
    stub_api_for(Traktion::Models::Show) do |s|
      s.get('shows/foobar') {|env| [200, {}, {title: 'foobar', ids: {slug: 'foobar'}}.to_json]}
      s.get('shows/popular') {|env| [200, {}, [{title: 'foo', ids: {slug: 'foo'}}, {title: 'foo', ids: {slug: 'foo'}}].to_json]}
      s.get('shows/trending') {|env| [200, {}, [{watchers: 100, show: {title: 'foo', ids: {slug: 'foo'}}}, {watchers: 50, show: {title: 'bar', ids: {slug: 'bar'}}}].to_json]}
      s.get('shows/updates/2014-09-22') {|env| [200, {}, [{updated_at: '2014-09-22', show: {title: 'foo', ids: {slug: 'foo'}}}, {updated_at: '2014-09-22', show: {title: 'bar', ids: {slug: 'bar'}}}].to_json]}
    end

    # Stubs for Alias
    stub_api_for(Traktion::Models::Alias) do |s|
      s.get('shows/foobar/aliases') {|env| [200, {}, [].to_json]}
    end

    # Stubs for Translation
    stub_api_for(Traktion::Models::Translation) do |s|
      s.get('shows/foobar/translations') {|env| [200, {}, [{title: 'foobar', overview: 'lorem ipsum', language: 'es'}].to_json]}
      s.get('shows/foobar/translations/es') {|env| [200, {}, {title: 'foobar', overview: 'lorem ipsum', language: 'es'}.to_json]}
    end

    @client = Traktion::Client.new('abc123')
  end

  it 'gets the summary of a show' do
    result = @client.shows.find('foobar')
    expect(result).not_to be nil
    expect(result.title).to eq('foobar')
  end

  it 'gets an array of the most popular shows' do
    result = @client.shows.popular
    expect(result).to be_an(Array)
    expect(result.size).to eq(2)
    expect(result.first.title).to eq('foo')
  end

  it 'gets an array of the trending shows' do
    result = @client.shows.trending
    expect(result).to be_an(Array)
    expect(result.size).to eq(2)
    expect(result.first.watchers).to eq(100)
    expect(result.first.show[:title]).to eq('foo')
  end

  it 'gets an array of recently updated shows' do
    result = @client.shows.updates('2014-09-22')
    expect(result).to be_an(Array)
    expect(result.first.updated_at).to eq('2014-09-22')
    expect(result.first.show[:title]).to eq('foo')
  end

  it 'gets an array of aliases for a show' do
    result = @client.shows.find('foobar').aliases
    expect(result).to be_an(Array)
  end

  it 'gets an array of translated details for a show' do
    result = @client.shows.find('foobar').translations
    expect(result).to be_an(Array)
    expect(result.first.title).to eq('foobar')
  end

  it 'gets the translated details for a show in a language' do
    result = @client.shows.find('foobar').translations('es')
    expect(result).to be_an(Traktion::Models::Translation)
    expect(result.title).to eq('foobar')
  end
end
