# WIP: Supercop

This gem allows you to combine multiple linters in one command and run them alltogether
with tabled-view report.
You should specify which linters you would use, for example rubocop, reek,
scss_linter etc. Gem would load them if they are not installed and run checks.

One gem for rule them all:)

I used ruby version 2.3.1, it don't think it would work for eralier versions of ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'supercop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install supercop

### Install into another gem

Add `copy_config` task to the Rakefile:

spec = Gem::Specification.find_by_name 'supercop'
load "#{spec.gem_dir}/lib/tasks/config_generator.rake"

## Usage

After install, you should modify supercop.yml and specify prefered linters.
After that run

  $ rake supercop:generate_config

for non-rails project (like gem) or

  $ rails g supercop:config

for rails project

### Running check

  $ rake supercop:check

  +--------------------+--------------------+--------------------+--------------------+
  |       linter       |       alerts       |        max         |       status       |
  +--------------------+--------------------+--------------------+--------------------+
  |      rubocop       |         48         |         99         |         ok         |
  |        reek        |         45         |         99         |         ok         |
  |     slim_lint      |        none        |         99         |         ok         |
  |     scss_lint      |        none        |         99         |         ok         |
  +--------------------+--------------------+--------------------+--------------------+

  'none' - means linter dod not work correctly. To figured out why - change 'verbose' option to true

## Development

After checking out the repo, run bundle install and make your changes. After commit, create Pull Request and notify me.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/artemasmith/supercop.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
