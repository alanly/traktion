require 'spec_helper'
require 'traktion/models/show'

describe Traktion::Models::Show do
  before do
    # Create stubs for the Show model.
    stub_api_for(Traktion::Models::Show) do |s|
      s.get('/shows/popular') {|env| [200, {}, [{title: 'foobar', ids: {trakt: 123, slug: 'foobar'}}].to_json]}
      s.get('/shows/trending') {|env| [200, {}, [{title: 'foobar', ids: {trakt: 123, slug: 'foobar'}}].to_json]}
      s.get('/shows/updates/2015-02-24') {|env| [200, {}, [{title: 'foobar', ids: {trakt: 123, slug: 'foobar'}}].to_json]}
      s.get('/shows/foobar') {|env| [200, {}, {title: 'foobar', ids: {trakt: 123, slug: 'foobar'}}.to_json]}
      s.get('/shows/foobar/aliases/') {|env| [200, {}, ['foo', 'bar', 'baz'].to_json]}
      s.get('/shows/foobar/translations/en') {|env| [200, {}, [{title: 'foobar', overview: 'lorem ipsum'}].to_json]}
      s.get('/shows/foobar/translations/') {|env| [200, {}, [{title: 'foobar', overview: 'lorem ipsum'}, {title: 'foobaz', overview: 'lorus ipsos'}].to_json]}
      s.get('/shows/foobar/comments/') {|env| [200, {}, [{id: 1, comment: 'yolo swag compound sentences'}, {id: 2, comment: 'hungarian rug burns'}].to_json]}
      s.get('/shows/foobar/people/') {|env| [200, {}, {cast: [{character: 'Fozzie Bear'}]}.to_json]}
      s.get('/shows/foobar/ratings/') {|env| [200, {}, {rating: 5, votes: 3, distribution: {}}.to_json]}
    end

    # Create the client instance.
    @control = Traktion.start('foobar')
  end

  it 'gets an array of the most popular shows' do
    response = @control.shows.popular
    expect(response).to be_an Array
  end

  it 'gets an array of trending shows' do
    response = @control.shows.trending
    expect(response).to be_an Array
  end

  it 'gets an array of all shows updated since a given date' do
    response = @control.shows.updates('2015-02-24')
    expect(response).to be_an Array
  end

  it 'gets the summary of a specific show' do
    response = @control.shows.find('foobar')
    expect(response).to be_a Traktion::Models::Show
    expect(response.title).to eq 'foobar'
  end

  it 'gets an array of title aliases for a specific show' do
    response = @control.shows.find('foobar').aliases
    expect(response).to be_an Array
  end

  it 'gets an array of one hash containing the translated attributes for a specific show, for given a language' do
    response = @control.shows.find('foobar').translations('en')
    expect(response).to be_an Array
    expect(response.size).to be 1
    expect(response.first[:title]).to eq 'foobar'
  end

  it 'gets an array of hashes containing the translated attributes for a specific show, for all available languages' do
    response = @control.shows.find('foobar').translations
    expect(response).to be_an Array
    expect(response.size).to be 2
    expect(response[1][:title]).to eq 'foobaz'
  end

  it 'gets an array of the comments for a specific show' do
    response = @control.shows.find('foobar').comments
    expect(response).to be_an Array
    expect(response.first[:comment]).to eq 'yolo swag compound sentences'
  end

  it 'gets all the cast and crew for a specific show' do
    response = @control.shows.find('foobar').people
    expect(response).to be_a Hash
    expect(response[:cast]).to be_an Array
    expect(response[:cast].first[:character]).to eq 'Fozzie Bear'
  end

  it 'gets the user ratings for a specific show' do
    response = @control.shows.find('foobar').ratings
    expect(response).to be_a Hash
    expect(response[:rating]).to be 5
  end
end
