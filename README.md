# WIP: Supercop

One gem for rule the other linters.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'supercop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install supercop

## Usage

### Install into another gem

Add `copy_config` task to the Rakefile:
spec = Gem::Specification.find_by_name 'supercop'
load "#{spec.gem_dir}/lib/tasks/config_generator.rake"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/artemasmith/supercop.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

