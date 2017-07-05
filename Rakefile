require "bundler/gem_tasks"
task :default => [:rubocop, :spec]

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new

require "rubocop/rake_task"
RuboCop::RakeTask.new

task :generate_parser do
  `cd $(bundle show parser) && bundle && bundle exec rake generate`
end
