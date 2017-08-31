# WIP: Supercop
[![Build Status](https://travis-ci.org/artemasmith/supercop.svg?branch=master)](https://travis-ci.org/artemasmith/supercop)

This gem allows you to combine multiple linters with their configs in one place and run all checks by one command with tabled-view summary report (see below).
You should specify which linters you would like to use, for example rubocop, reek,
scss_linter etc. Gem would load them if they are not installed and run checks.

One gem for rule them all:)

### Versions

I used ruby MRI version 2.3.1. I also tried version 2.2.3.

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

Add supercop tasks to the Rakefile:

```ruby
  spec = Gem::Specification.find_by_name 'supercop'
  load "#{spec.gem_dir}/lib/tasks/manage_settings.rake"
  load "#{spec.gem_dir}/lib/tasks/check.rake"
```

## Usage

After install, you should modify supercop.yml and specify prefered linters.
After that run

    $ rake supercop:generate_config

for non-rails project (like gem) or

    $ rails g supercop:config

for rails project

After that, please modify your supercop.yml config file, adding linters you want to use and run

    $ rake supercop:load_dependencies

or you can do it manually by adding gems to your Gemfile (for other gems - to the end of file) and running bundle install.

`Note:` You should do it once.

Now you can run checks.

### Running check

    $ rake supercop:check

  |       linter       |       alerts       |        max         |       status       |
  | ------------------ |:------------------:|:------------------:|:------------------:|
  |      rubocop       |         48         |         99         |         ok         |
  |        reek        |         45         |         99         |         ok         |
  |     slim_lint      |        none        |         99         |         ok         |
  |     scss_lint      |        none        |         99         |         ok         |

  'none' - means linter did not work correctly. To figured out why - change 'verbose' option to true

## Development

After checking out the repo, run bundle install and make your changes. After commit, create Pull Request and notify me.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/artemasmith/supercop.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
