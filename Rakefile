#!/usr/bin/env rake
require 'rubocop/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
desc 'Runs rspec tests'
task :test => :spec

desc 'Runs foodcritic linter'
task :foodcritic do
  FoodCritic::Rake::LintTask.new do |t|
    t.options = { exclude_paths: ['spec'],
                  tags: ['~FC001']
     }
  end
end

desc 'Runs Rubocop linter.'
task :rubocop do
  Rubocop::RakeTask.new
end

desc 'DVM'
task :dvm do
  puts "To start 'dvm' in this environment, copy and press [ENTER]"
  puts ""
  puts "dvm up"
  puts "eval $(dvm env)"
end

task default:  %w[foodcritic rubocop test]