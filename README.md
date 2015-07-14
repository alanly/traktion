# Traktion

Traktion is an API client for Trakt.tv's V2 API. Based on the [Her ORM](https://github.com/remiprev/her) library, Traktion allows you to interface with the Trakt.tv API as if it's endpoints are Rails models. This means that it's extremely easy and intuitive to build applications that make use of Trakt.tv's vast dataset.

This API client is targetted at server side applications that will build upon the Trakt data, such as querying metadata for a personal video library. It is not intended for applications that require client-side authentication (i.e. OAuth) in order to interface with an end-user's Trakt.tv account.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'traktion'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install traktion

## Usage

Obtain a **Client ID** from Trakt.tv by [applying for API access](https://trakt.tv/oauth/applications). Once you have registered an API application on Trakt.tv, you will find the ID/key in the respective application's _Details_ page.

After having installed Traktion, you can use it by first obtaining the client instance (called Traktion Control, huehuehue) by calling the `.start` method with the client ID you've obtained:

```ruby
client = Traktion.start('<client ID>')
```

Once you have the client instance, you may now perform queries against the Trakt.tv API. For example, to get the summary for a TV show, you'd call the `find` method with the appropriate slug value on the `shows` resource.

```ruby
client.shows.find('community')
#<Traktion::Models::Show(shows) title="Community" year=2009 ids={"trakt"=>18265, "slug"=>"community", "tvdb"=>94571, "imdb"=>"tt1439629", "tmdb"=>18347, "tvrage"=>22589}>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

The client is currently incomplete, with a lot of the Trakt API endpoints currently being unimplemented. If you need access to a specific endpoint and/or are interested in contributing, bug reports and pull requests are always welcomed on GitHub at https://github.com/alanly/traktion.


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

