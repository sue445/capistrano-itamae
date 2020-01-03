# Capistrano::Itamae

Run [itamae](https://github.com/itamae-kitchen/itamae) in capistrano task

[![Gem Version](https://badge.fury.io/rb/capistrano-itamae.svg)](https://badge.fury.io/rb/capistrano-itamae)
[![Build Status](https://github.com/sue445/capistrano-itamae/workflows/test/badge.svg?branch=master)](https://github.com/sue445/capistrano-itamae/actions?query=workflow%3Atest)
[![Code Climate](https://codeclimate.com/github/sue445/capistrano-itamae/badges/gpa.svg)](https://codeclimate.com/github/sue445/capistrano-itamae)

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
set :itamae_cookbooks_path, "cookbooks"

set :itamae_ssh_default_options, "--node-yaml=node.yml"

desc "Run itamae"
  task :itamae do
    on roles(:all) do
      # Run itamae ssh --node-yaml=node.yml cookbooks/default.rb
      itamae_ssh

      # Run itamae ssh --node-yaml=node.yml cookbooks/recipe.rb
      itamae_ssh "recipe.rb"

      # Run itamae ssh --node-yaml=node.yml cookbooks/recipe1.rb cookbooks/recipe2.rb
      itamae_ssh ["recipe1.rb", "recipe2.rb"]

      # Run itamae ssh --node-yaml=node.yml cookbooks/recipe.rb --no-sudo --log-level=debug
      itamae_ssh "recipe.rb", options: "--no-sudo --log-level=debug"

      # Pass $PATH to `itamae ssh`
      itamae_ssh "recipe.rb", environment: { path: ENV["PATH"] }
    end
  end
end
```

```bash
# Run itamae ssh --dry-run 〜
$ bundle exec cap --dry-run 〜

# Run itamae ssh 〜
$ bundle exec cap 〜
```

see [Capistrano::Itamae::DSL#itamae_ssh](lib/capistrano/itamae/dsl.rb)

## Variables
* `itamae_cookbooks_path` : path to cookbooks dir (default: `"cookbooks"`)
* `itamae_bin_name` : itamae executable name (default: `"itamae"`)
* `itamae_ssh_default_options` : `itamae ssh` default options (default: empty)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Integration test
```sh
cd spec/integration
docker image build . -t ssh_server
docker run -d -p 10000:22 ssh_server
bundle exec rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/capistrano-itamae.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

