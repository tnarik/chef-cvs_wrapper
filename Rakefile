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