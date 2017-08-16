require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

import './lib/tasks/config_generator.rake'
import './lib/tasks/check.rake'

RSpec::Core::RakeTask.new(:spec)

task default: :spec
