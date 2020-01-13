# RestApi

Wrapper around RestClient for defining a restful network API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rest_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rest_api

## Usage

Consider [an api of Ice and Fire](https://anapioficeandfire.com/). We can define a `RestApi` like so:
```rb
module ASOIF
  class BaseApi < RestApi::Base
    BASE_URL = 'https://anapioficeandfire.com/api/'
  end
end

module ASOIF
  class Character < BaseApi
    class << self
      
      def find(id)
        get "characters/#{id}"
      end
      
      def all_alive
        get 'characters?isAlive=true'
      end
      
    end
  end
end

module ASOIF
  class House < BaseApi
    class << self
      
      def all
        get 'houses'
      end
      
      def create(params)
        post 'houses', params
      end
      
    end
  end
end
```

This library takes an opinion on response parsing. Two things to note:
  1. Response format is assumed JSON and parsed using `JSON.parse`
  2. Rather than return a hash of hashes, a [`RecursiveOpenStruct`](https://github.com/lazyvar/rest_api/blob/master/lib/recursive_open_struct.rb) is returned
  
These two factors allow for the following call syntax:
```rb
john_snow = ASOIAF::Character.find(583)
puts john_snow.titles.first # "Lord Commander of the Night's Watch"
```

`ResApi` allows defining of `base_headers` that will be passed into every requst. This is commonly used for authentication.

```rb
module NSA
  class BaseApi < RestApi::Base

  BASE_URL = Settings.urls.nsa

    class << self

      private

      def base_headers
        { :Authorization => "Token token=#{Settings.nsa.secret}" }
      end

    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lazyvar/rest_api.
