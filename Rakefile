require "bundler/gem_tasks"
task :default => [:generate_parser, :rubocop, :spec]

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new

require "rubocop/rake_task"
RuboCop::RakeTask.new

task :generate_parser do
  command = [
    "cd $(bundle show parser)",
    "BUNDLE_GEMFILE=./Gemfile bundle",
    "BUNDLE_GEMFILE=./Gemfile bundle exec rake generate"
  ].join(" && ")

  puts "Generating Parser files..."
  `#{command}`
end
