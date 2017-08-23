require 'supercop'

desc 'Cops your code with configured linters and prints table report'
namespace :supercop do
  task :check do
    Supercop::Checker.new.call
  end
end
