# Capistrano::Itamae

Run [itamae](https://github.com/itamae-kitchen/itamae) in capistrano task

[![Gem Version](https://badge.fury.io/rb/capistrano-itamae.svg)](https://badge.fury.io/rb/capistrano-itamae)

[![wercker status](https://app.wercker.com/status/a2f734cda581d3d221e10b1ede83bb71/m/master "wercker status")](https://app.wercker.com/project/bykey/a2f734cda581d3d221e10b1ede83bb71)

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem "capistrano-itamae", require: false
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-itamae

## Usage

Capfile

```ruby
require "capistrano/itamae"
```

config/deploy.rb

```ruby
desc "Run itamae"
  task :itamae do
    on roles(:all) do
      itamae_ssh "/path/to/recipe.rb"
    end
  end
end
```

## Variables
* `itamae_path` : path to itamae executable file (default: `bundle exec itamae`)
* `itamae_default_options` : (default: `[]`)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Integration test
```sh
cd spec/integration
bundle exec vagrant up
bundle exec rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/capistrano-itamae.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

