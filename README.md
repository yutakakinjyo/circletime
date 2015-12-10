# CircleTime

[![Build Status](https://travis-ci.org/yutakakinjyo/circletime.svg)](https://travis-ci.org/yutakakinjyo/circletime)

CircleTime get amount of build time from organization on [CircleCI](https://circleci.com/).  
Free plan of CircleCI limit is 1,500 min build time. So sometimes we want to know how many spend build time already.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'circletime'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install circletime

## Usage

```
mv .env.sample .env
```

and set your circle ci access token like following

.env
```
CIRCLE_CI_TOKEN='your access token'
```

```ruby
require 'circlecitime'

build_time = CircleTime::BuildTime.new("specify organizaion name")

# you will get msec of build time 
today = build_time.today

puts today / 1000.0 / 60 # min
```

you can get some term.

```ruby
yestaday = build_time.yestaday
week = build_time.week
month = build_time.month
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/circletime. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

